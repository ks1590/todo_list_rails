class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  validate :date_cannot_be_in_the_past

  enum priority: { 低: 0, 中: 1, 高: 2 }

  def date_cannot_be_in_the_past
    if deadline < Date.today
      errors.add(:deadline, "過去の日付は設定できません。")
    end
  end

  scope :search, -> (get_params) do
    name = get_params[:name]
    status = get_params[:status]
    # label = get_params[:label_id]
    return if get_params.blank?
    if name.present? && status.present?
      name_like(name).status(status)
    elsif name.present? && status.present?
      name_like(name).status(status)
    # elsif name.present? && label.present?
    #   name_like(name).label(label)
    # elsif status.present? && label.present?
    #   status(status).label(label)
    elsif name.present?
      name_like(name)
    elsif status.present?
      status(status)
    # elsif label.present?
    #   label(label)
    end
  end

  scope :name_like, -> name { where('name LIKE ?', "%#{name}%") }
  scope :status, -> status { where(status: status) }
  scope :deadline, -> { order(deadline: :desc) }
  scope :default, -> { order(created_at: :desc) }
  scope :priority, -> { order(priority: :desc) }
  # scope :label, -> label_id { joins(:labels).where(labels:  { id: label_id }) }
end