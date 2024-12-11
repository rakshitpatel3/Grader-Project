class Section < ApplicationRecord
  belongs_to :course

  validates :instructor, presence: true
  validates :time, presence: true

  scope :search, ->(query) { where("instructor LIKE ?", "%#{query}%") }
end
