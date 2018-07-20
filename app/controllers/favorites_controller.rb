class FavoritesController < ApplicationController
  def index
    @favorites_plans = current_user.favorite_plans
    
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        # 詳細画面のHTMLを取得
        html = render_to_string template: "favorites/index"

        # PDFKitを作成
        pdf = PDFKit.new(html, encoding: "UTF-8"

        pdf.stylesheets << "#{Rails.root}/app/assets/stylesheets/plans.scss"
        pdf.stylesheets << "#{Rails.root}/app/assets/stylesheets/bootstrap.min.css"
        
        # 画面にPDFを表示する
        # to_pdfメソッドでPDFファイルに変換する
        # 他には、to_fileメソッドでPDFファイルを作成できる
        # disposition: "inline" によりPDFはダウンロードではなく画面に表示される
        send_data pdf.to_pdf,
          filename:    "#{@favorites_plans.id}.pdf",
          type:        "application/pdf",
          disposition: "inline"
      end
     end
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
