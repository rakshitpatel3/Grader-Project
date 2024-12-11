class Section < ApplicationRecord
  belongs_to :course
  
  validates :instructor, presence: true
  validates :time, presence: true

  scope :search, ->(query) { where("instructor LIKE ?", "%#{query}%") }

  has_many :grader_applications
  validates :graders_required, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def graders_assigned
    grader_applications.count || 0
  end

  def graders_needed
    (graders_required || 0) - graders_assigned
  end
  
end
