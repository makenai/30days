class CommitmentsController < SecureController
  
  def index
    @commitments = current_user.active_commitments
  end
  
  def show
    @commitment = current_user.commitments.find( params[:id] )
  end
  
  
end
