class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :number
      t.string :name

      t.timestamps
    end
  end
end
