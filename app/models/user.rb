class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  # 名前を必須にし、50文字以内にする
  validates :name, presence: true, length: { maximum: 50 }

  # 診断結果との関連付け（1対多）
  has_many :diagnoses, dependent: :destroy

  has_one_attached :avatar

  # ファイルの種類とサイズのバリデーション（gem ActiveStorage Validationを使用）
  ACCEPTED_CONTENT_TYPES = %w[image/jpeg image/png image/gif image/webp].freeze
  validates :avatar, content_type: ACCEPTED_CONTENT_TYPES,
                    size: { less_than_or_equal_to: 5.megabytes }
end
