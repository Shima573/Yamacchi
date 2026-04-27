class FavoritesController < ApplicationController
  def index
    # 表示用データ
    @favorite_mountains = current_user.favorite_mountains
    # 判定用データ
    @favorite_ids = current_user.favorites.pluck(:mountain_id)
  end

  def create
    # 山を取得
    @mountain = Mountain.find(params[:mountain_id])
    # お気に入り登録
    current_user.favorite(@mountain)
    # 【追加】再描画に使うため、最新のID一覧を取得する
    @is_favorited = true
    # リダイレクト
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: mountains_path }
    end
  end

  def destroy
    # 山を取得
    @mountain = Mountain.find(params[:mountain_id])
    # お気に入り登録解除
    current_user.unfavorite(@mountain)
    # 【追加】削除後の最新のID一覧を取得する
    @is_favorited = false
    # リダイレクト
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: mountains_path }
    end
  end
end
