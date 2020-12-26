class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  # before_create :date_cannot_be_in_the_past

  enum priority: { 低: 0, 中: 1, 高: 2 }

  # def date_cannot_be_in_the_past
  #   if deadline < Date.today
  #     errors.add(:deadline, "過去の日付は設定できません。")
  #   end
  # end
end