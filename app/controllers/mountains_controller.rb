class MountainsController < ApplicationController
  # ログインしていない場合はログイン画面へ飛ばす
  before_action :authenticate_user!

  def index
  end

  def show
  end
end
