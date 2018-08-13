class CommentsController < ApplicationController
  
  def create
    @plan = Plan.find(params[:comment][:plan_id])
    @comment = @plan.comments.build(comment_params)
    @comment.save
    redirect_to plan_path(params[:comment]['plan_id'])

    
    # @plan = Plan.find(params[:plan_id])
    # @plan.comments.create(comment_params)
    # redirect_to plan_path(@plan)
  end
  
  def destroy
    @plan = Plan.find(params[:plan_id])
    @comment = @plan.comments.find(params[:id])
    @comment.destroy
    redirect_to plan_path(@plan)
  end
  
  private 
  def comment_params
    params.require(:comment).permit(:body)
  end

end
