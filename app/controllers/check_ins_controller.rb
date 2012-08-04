class CheckInsController < ApplicationController

	def create
		check_in = CheckIn.new( params[:check_in] )
		if check_in.save
			render :text => 'OK!'
		else
			render :text => 'Nononononono'
		end
	end

end
