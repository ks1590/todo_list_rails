class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validate :date_cannot_be_in_the_past

  belongs_to :user

  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  enum priority: { 低: 0, 中: 1, 高: 2 }

  def date_cannot_be_in_the_past
    if deadline < Date.today - 1
      errors.add(:deadline, "過去の日付は設定できません。")
    end
  end

  scope :search, -> (search_params) do
    name = search_params[:name]
    status = search_params[:status]
    label = search_params[:label_id]
    return if search_params.blank?
    name_like(name).check_status(status).check_label(label)
  end

  scope :name_like, -> name { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :check_status, -> status { where(status: status) if status.present? }
  scope :deadline, -> { order(deadline: :desc) }
  scope :default, -> { order(created_at: :desc) }
  scope :priority, -> { order(priority: :desc) }
  scope :check_label, -> label_id { joins(:labels).where(labels: { id: label_id }) if label_id.present? }
end