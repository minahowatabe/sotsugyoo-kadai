class FavoritesController < ApplicationController
  def index
    @favorite = current_user.favorites.find_by(plan_id: @plan.id)
  end

  def create
    favorite = current_user.favorites.create(plan_id: params[:plan_id])
    redirect_to plans_url, notice: "ADD Portfolio"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to plans_url, notice: "DELETE Portfolio"
  end
  
end
