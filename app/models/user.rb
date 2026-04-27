class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_mountains, through: :favorites, source: :mountain

  # 名前を必須にし、50文字以内にする
  validates :name, presence: true, length: { maximum: 50 }

  # 診断結果との関連付け（1対多）
  has_many :diagnoses, dependent: :destroy

  has_one_attached :avatar

  # お気に入り関連
  # 　登録する
  def favorite(mountain)
        favorite_mountains << mountain
  end
  # 解除する
  def unfavorite(mountain)
        favorites.where(mountain_id: mountain.id).delete_all
  end
  # 状態を確認する
  def favorited?(mountain)
        favorites.exists?(mountain_id: mountain.id)
  end

  # ファイルの種類とサイズのバリデーション（gem ActiveStorage Validationを使用）
  ACCEPTED_CONTENT_TYPES = %w[image/jpeg image/png image/gif image/webp].freeze
  validates :avatar, content_type: ACCEPTED_CONTENT_TYPES, size: { less_than_or_equal_to: 5.megabytes }
end
