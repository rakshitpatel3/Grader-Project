class GraderApplication < ApplicationRecord
  belongs_to :user
  belongs_to :section, optional: true
  validates :availability, presence: true
  validates :course_number, presence: true

  def course
    Course.find_by(number: course_number)
  end
end
