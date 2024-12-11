class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: { with: /\A[\w+\-.]+\.?\d*@osu\.edu\z/i, message: "must be an OSU email" }
  validates :role, presence: true, inclusion: { in: %w(Student Instructor Admin) }
  
  validates :name, presence: true
  validates :approved, inclusion: { in: [true, false] }

  before_create :set_default_approval

  # Role-based methods
  def student?
    role == 'Student'
  end

  def instructor?
    role == 'Instructor'
  end

  def admin?
    role == 'Admin'
  end

  private

  def set_default_approval
    self.approved = true if student?
    self.approved = false if instructor? || admin?
  end
end
