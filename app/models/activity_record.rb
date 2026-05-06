class ActivityRecord < ApplicationRecord
  belongs_to :user
  belongs_to :mountain

  validates :title, presence: true
  validates :body, length: { maximum: 500 }
  validates :climbed_at, presence: true
  validate :climbed_at_cannot_be_in_future

  def climbed_at_cannot_be_in_future
    if climbed_at.present? && climbed_at > Time.current
      errors.add(:climbed_at, "は未来の日付を選択できません")
    end
  end
end
