class IconsController < ApplicationController

	def index
		@icons = Icon.order('name desc')
	end


end
