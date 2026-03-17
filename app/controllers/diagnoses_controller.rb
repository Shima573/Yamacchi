class DiagnosesController < ApplicationController
  # ログインしていなくても診断は可能
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    # 質問フォームを表示
  end

  def create
    # モデルのメソッドを使ってインスタンスを作成（保存はしない）
    @diagnosis = Diagnosis.build_from_answers(params)

    if user_signed_in?
      @diagnosis.user = current_user
      @diagnosis.save!
      redirect_to diagnosis_path(@diagnosis)
    else
      # 未ログインならセッションにハッシュとして保存
      session[:pending_diagnosis] = @diagnosis.attributes.except("id", "created_at", "updated_at")
      @recommended_mountains = Mountain.recommend_for(@diagnosis)
      render :show
    end
  end

  def show
    if params[:id]
      @diagnosis = Diagnosis.find(params[:id])
    elsif session[:pending_diagnosis]
      @diagnosis = Diagnosis.new(session[:pending_diagnosis])
    else
      return redirect_to new_diagnosis_path
    end

    # 検索ロジックもモデル側に丸投げ
    @recommended_mountains = Mountain.recommend_for(@diagnosis)
  end
end
