class AddSectionIdentifierToSections < ActiveRecord::Migration[7.2]
  def change
    add_column :sections, :section_identifier, :string
  end
end
