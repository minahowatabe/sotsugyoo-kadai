class FavoritesController < ApplicationController
  def index
    @favorites_plans = current_user.favorite_plans
  end

  def create
    favorite = current_user.favorites.create(plan_id: params[:plan_id])
    redirect_to plans_url, notice: "Portfolioに追加しました！"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to plans_url, notice: "Portfolioから削除しました！"
  end
  
end
