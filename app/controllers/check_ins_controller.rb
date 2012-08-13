class CheckInsController < ApplicationController

	def create
		if check_in = CheckIn.where( :commitment_id => params[:commitment_id], :checkin_date => params[:check_in][:checkin_date] ).first
			note = params[:check_in][:note]
			if note.present?
				check_in.update_attributes({ :note => note })
			else
				check_in.destroy
			end
		else
			check_in = CheckIn.new( params[:check_in] )
			if commitment = Commitment.find( params[:commitment_id] )
				check_in.commitment_id = commitment.id
			end
			check_in.save
		end
		if check_in.errors.present?
			render :text => check_in.errors.full_messages.join("\n"), :status => 400
		else
			render :partial => 'commitments/day', :locals => { :day => check_in.to_day }
		end
	end

end
