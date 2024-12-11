class CreateSections < ActiveRecord::Migration[7.2]
  def change
    create_table :sections do |t|
      t.references :course, null: false, foreign_key: true
      t.string :instructor
      t.string :time

      t.timestamps
    end
  end
end
