class AddCatalogNumberToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :catalog_number, :string
  end
end
