class CommitmentsController < SecureController
  
  def index
    @commitments = current_user.active_commitments
    @check_ins = []
    if params[:month]
    	@date = Date.parse("#{params[:month]}-01")
    else
		@date = Date.today
    end
    if request.xhr?
    	render :partial => 'calendar', :locals => { :date => @date, :check_ins => @check_ins } and return
    end
  end
  
  def show
    @commitment = current_user.commitments.find( params[:id] )
  end
  
  
end
