class PagesController < ApplicationController
  # 基本的にTOPページはログイン前でも見れるため、Deviseを導入した後は
  # skip_before_action :authenticate_user! などが必要になりますが、今は空でOKです。
  skip_before_action :authenticate_user!, only: [ :top ]

  def top
  end
end
