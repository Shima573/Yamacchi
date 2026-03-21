class ApplicationController < ActionController::Base
  # デフォルトで全ページをログイン必須にする
  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Deviseのコントローラー（登録、ログイン、パスワード編集など）が動くときだけ、
  # configure_permitted_parameters メソッドを実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ（新規登録）の際に、emailとpassword以外に「name」の保存も許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])

    # アカウント更新（プロフィール編集）の際に、emailとpassword以外に「name」の変更も許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
