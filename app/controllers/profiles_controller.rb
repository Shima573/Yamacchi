class ProfilesController < ApplicationController
  # ログインしていない場合はログイン画面へ飛ばす
  before_action :authenticate_user!

  def show
    # resources :profiles の場合は params[:id] が必要ですが、
    # マイページとして使う場合は current_user を基本にします
    @user = current_user

    # 今後、診断履歴（@diagnoses）や
    # お気に入り（@favorite_mountains）をここで取得するように拡張できる
    @diagnosis = current_user.diagnoses.last
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
