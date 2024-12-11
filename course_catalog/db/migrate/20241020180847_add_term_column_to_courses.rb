class AddTermColumnToCourses < ActiveRecord::Migration[7.2]
    def change
      add_column :courses, :term, :string
    end
end
