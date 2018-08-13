class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index,:new, :show, :edit, :update, :destroy]
  
  def top
  end
  
  def index
    @plans = current_user.plans.all
    # binding.pry
    @plans = @plans.search(params[:search])
   
  end
  
  def new
    # @plan = current_user.plan.news.build
    if params[:back]  
      @plan = Plan.new
    else 
      @plan = Plan.new
    end
  end
  
  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
      if @plan.save
      redirect_to plans_path, notice: "教案作成しました！"
    
      else
      render 'new'  
      end
    
  end
  
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        # 詳細画面のHTMLを取得
        html = render_to_string template: "plans/show"

        # PDFKitを作成
        pdf = PDFKit.new(html, encoding: "UTF-8")

        pdf.stylesheets << "#{Rails.root}/app/assets/stylesheets/plans.scss"
        pdf.stylesheets << "#{Rails.root}/app/assets/stylesheets/bootstrap.min.css"
        
        # 画面にPDFを表示する
        # to_pdfメソッドでPDFファイルに変換する
        # 他には、to_fileメソッドでPDFファイルを作成できる
        # disposition: "inline" によりPDFはダウンロードではなく画面に表示される
        send_data pdf.to_pdf,
          filename:    "#{@plan.id}.pdf",
          type:        "application/pdf",
          disposition: "inline"
      end
    end

    @plan = Plan.find(params[:id])
    @newcomment = Comment.new(:plan_id => params[:id])
    @comments = Comment.where(plan_id: params[:id])
    
    
    @plan = Plan.find(params[:id])
    
    @favorite = current_user.favorites.find_by(plan_id: @plan.id)  
  end
  
  def comment
  end
  
  def edit
  end
  
  def update
    if @plan.update(plan_params)
       redirect_to plans_path, notice:"更新しました。"
    else
     render 'new'
    end
  end
  
  def destroy
    @plan.destroy
    redirect_to plans_path, notice:"削除しました。"   
    
    # favorite = current_user.favorites.find_by(id: params[:id]).destroy
    # redirect_to plans_url, notice: "教案をポートフォリオから解除しました"
  end
  
  def confirm
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    render :new  if @plan.invalid?  
  end
  
  def comment
    # @plan.user_id = current_user.id
    @plan = Plan.find(params[:id])
  end
  
  private
  def plan_params
    # params[:plan]
    params.require(:plan).permit(:lessondate, :goal, :item, :content, :image_cache)
  end
  
  def set_plan
    # @plan = current_user.plans.find(params[:id])
    @plan = Plan.find(params[:id])
  end

  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_path) unless current_user?(@user)
  # end
  
end
