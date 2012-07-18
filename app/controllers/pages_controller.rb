class PagesController < ApplicationController
  
  def home
    redirect_to user_root_path if user_signed_in?
    @inspiration = YAML.load_file( Rails.root.join('config', 'inspiration.yml') ).sort { rand }
  end
  
end
