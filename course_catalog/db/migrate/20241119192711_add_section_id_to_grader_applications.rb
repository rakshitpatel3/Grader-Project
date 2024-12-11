class AddSectionIdToGraderApplications < ActiveRecord::Migration[7.2]
  def change
    add_column :grader_applications, :section_id, :integer
  end
end
