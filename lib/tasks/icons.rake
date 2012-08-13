require 'open-uri'
require 'nokogiri'
require 'tempfile'

CONVERT_BIN = '/usr/local/bin/convert'

#  --export-png=fish.png ~/Downloads/f/noun_project_1248.svg 
# convert -trim -negate fish.png  fish2.png

namespace :icons do

  desc "Insert the icons into the database"
  task :insert => :environment do
  	Icon.delete_all
  	icons = YAML.load_file( Rails.root.join('db/icons.yaml') )
  	icons.each do |icon_data|
  		Icon.create( icon_data )
  	end
  end

  desc "Update the icons in config/icons.txt"
  task :update => :environment do
  	FileUtils.mkpath( Rails.root.join('app/assets/images/icons') )
  	icons = []
    File.open( Rails.root.join('config/icons.txt') ).each_line do |url|
    	noun = url.match(%r{/noun/(\S+)/})[1] rescue 'unknown'
    	if id = url.match(/No(\d+)$/)[1] rescue nil
    		doc = Nokogiri::HTML( open( url.chomp ) )
    		if node = doc.css('#icon-' + id).first
    			license = node.attr('data-license')
    			source = node.attr('data-source')
    			attribution = node.attr('data-attributeas')
    			tags = node.attr('data-tags')
    			svg_data  = node.inner_html
    			name = "#{noun}-#{id}"

    			icons << {
    				:name        => name,
    				:license     => license,
    				:source      => source,
    				:url         => url.chomp,
    				:attribution => attribution,
    				:tags        => tags
    			}

    			Tempfile.open(['icon', '.svg']) do |svg_file|
    				svg_file.write( svg_data )
    				svg_file.close
    				png_file = Tempfile.new(['icon', '.png'])

    				system( CONVERT_BIN, '+antialias', 
    						'-transparent', 'white', 
    						'-density', '1000', 
    						'-negate', 
    						'-trim', 
    						svg_file.path, 
    						png_file.path )

    				system( CONVERT_BIN,
    						'-resize', '28x28',
    						'-extent', '36x36',
    						'-background', 'none',
    						'-gravity', 'center',
    						png_file.path,
    						Rails.root.join('app/assets/images/icons', "#{name}.png" ).to_s
    					)

    				system( CONVERT_BIN,
    						'-resize', '14x14',
    						'-extent', '18x18',
    						'-background', 'none',
    						'-gravity', 'center',
    						png_file.path,
    						Rails.root.join('app/assets/images/icons', "#{name}-sm.png" ).to_s
    					)
    			end
    		end
    	end
    end
    File.open( Rails.root.join('db/icons.yaml'), 'w' ) do |file|
    	file.write( icons.to_yaml )
    end
    File.open( Rails.root.join('app/assets/stylesheets/icons.css.scss'), 'w' ) do |file|
    	icons.each do |icon|
	    	file.puts ".icon.#{icon[:name]} { background-image: image-url('icons/#{icon[:name]}.png') }"
	    	file.puts ".icon.small.#{icon[:name]} { background-image: image-url('icons/#{icon[:name]}-sm.png') }"
	    end
    end
  end

end