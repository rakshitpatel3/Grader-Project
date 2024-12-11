class Course < ApplicationRecord
  has_many :sections, dependent: :destroy
  
  #validates :number, presence: true, uniqueness: true, format: { with: /\ACSE\s\d{4}/, message: "must be in the format 'CSE XXXX'" }
  validates :name, presence: true

  attribute :lab_assistant_required, :boolean, default: false

  scope :by_level, ->(level) { where("number LIKE ?", "CSE #{level}%") }
  scope :search, ->(query) { where("number LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%") }

  def self.course_levels
    distinct.pluck('substr(number, 5, 1)').sort
  end
end
