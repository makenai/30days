require 'digest/md5'

module ApplicationHelper

	def avatar
		hash = Digest::MD5.hexdigest( current_user.email.downcase )
		return "http://www.gravatar.com/avatar/#{hash}?d=monsterid"
	end

end
