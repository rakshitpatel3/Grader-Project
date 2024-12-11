class CreateRecommendations < ActiveRecord::Migration[7.2]
  def change
    create_table :recommendations do |t|
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true
      t.string :recommendation_type
      t.text :comments
      t.references :section, null: true, foreign_key: true

      t.timestamps
    end
  end
end