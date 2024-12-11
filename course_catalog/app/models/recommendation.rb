class Recommendation < ApplicationRecord
    belongs_to :instructor, class_name: 'User'
    belongs_to :student, class_name: 'User'
    belongs_to :course
    belongs_to :section, optional: true
  
    validates :recommendation_type, presence: true, 
              inclusion: { in: ['future_consideration', 'specific_section'] }
    validates :comments, presence: true
    
    validate :instructor_must_be_instructor
    validate :student_must_be_student
    
    private
    
    def instructor_must_be_instructor
      unless instructor&.instructor?
        errors.add(:instructor, "must be an instructor")
      end
    end
    
    def student_must_be_student
      unless student&.student?
        errors.add(:student, "must be a student")
      end
    end
end