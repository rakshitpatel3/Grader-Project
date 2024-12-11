# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Do rails db:seed 
User.find_or_create_by!(email: 'admin.1@osu.edu') do |user|
  user.name = 'Admin User'
  user.email = 'admin.1@osu.edu'
  user.password = 'password' 
  user.password_confirmation = 'password'
  user.role = 'Admin'
  user.approved = true
end

# Add sample courses
Course.find_or_create_by!(number: 'CSE 1010') do |course|
  course.name = 'Introduction to Computer Science'
end

Course.find_or_create_by!(number: 'CSE 1020') do |course|
  course.name = 'Data Structures'
end

Course.find_or_create_by!(number: 'CSE 2010') do |course|
  course.name = 'Algorithms'
end
