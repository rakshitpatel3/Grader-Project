class AddCourseNumberToGraderApplications < ActiveRecord::Migration[7.2]
  def change
    add_column :grader_applications, :course_number, :string
  end
end
