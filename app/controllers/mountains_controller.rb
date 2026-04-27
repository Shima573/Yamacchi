class MountainsController < ApplicationController
  # ログインしていない場合はログイン画面へ飛ばす
  before_action :authenticate_user!

  def index
    @favorite_ids = current_user.favorites.pluck(:mountain_id)
    @has_diagnosis = current_user.diagnoses.exists?

    if @has_diagnosis
      @recommended_mountains = Mountain.recommend_for(current_user.diagnoses.last)
    end
  end

  def show
    @mountain = Mountain.find(params[:id])
    @is_favorited = current_user.favorited?(@mountain)
    @diagnosis = current_user.diagnoses.last
  end
end
