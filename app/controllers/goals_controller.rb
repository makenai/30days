class GoalsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [ :create ]
  
  def create
    # Create the goal
    goal = Goal.where( :slug => Goal.slug( params[:goal][:name] ) ).first
    if !goal
      goal = Goal.new( params[:goal] )
      goal.user = current_user
      goal.save
    end
    
    # Check for existing commitment
    existing = current_user.commitments.where("goal_id = ? AND end_date > ?", goal.id, Date.today ).first
    if existing
      flash[:notice] = 'You are already commited to this goal!'
    else
      # Create a new commitment
      commitment = Commitment.create( :goal_id => goal.id, :user_id => current_user.id )
      if !commitment.valid?
        flash[:notice] = commitment.errors.full_messages.join(' ')
      end      
    end
    
    redirect_to commitments_path
  end
  
end
