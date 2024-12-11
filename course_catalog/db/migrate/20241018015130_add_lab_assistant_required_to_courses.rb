class AddLabAssistantRequiredToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :lab_assistant_required, :boolean
  end
end
