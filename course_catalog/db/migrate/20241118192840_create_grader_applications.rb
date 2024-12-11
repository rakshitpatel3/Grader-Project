class CreateGraderApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :grader_applications do |t|
      t.references :user, null: false, foreign_key: true
      t.text :availability
      t.text :course_ids

      t.timestamps
    end
  end
end
