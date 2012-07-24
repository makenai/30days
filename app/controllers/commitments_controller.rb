class CommitmentsController < SecureController
  
  def index
    @commitments = current_user.active_commitments
    @check_ins = []
    @date = Date.today
  end
  
  def show
    @commitment = current_user.commitments.find( params[:id] )
  end
  
  
end
