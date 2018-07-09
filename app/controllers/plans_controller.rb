class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [ :destroy]
  # 暫定的にコメントアウト:show, :edit, :update,
  def top
  end
  
  def index
    @plans = Plan.all
  end
  
  def new
    # @plan = current_user.plan.build
    if params[:back]  
      @plan = Plan.new(plan_params)
    else 
      @plan = Plan.new
    end
  end
  
  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    render 'new'  
  end
  
  def show
  end
  
  def edit
  end
  
  def updated
    if @plan.update(plan_params)
        redirect_to plans_path, notice:"更新しました。"
    else
      render 'new'
    end
  end
  
  def destroy
    @plan.destroy
    redirect_to plans_path, notice:"削除しました。"   
  end
  
  def confirm
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    render 'new' if @plan.invalid?  

  end
  
  private
  def plan_params
    params.require(:plan).permit(:lessondate, :goal, :item, :content, :comment)
  end
  
  def set_plan
    @plan = Plan.find(params[:id])
  end

  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_path) unless current_user?(@user)
  # end
  
end
