class AddGradersRequiredToSections < ActiveRecord::Migration[7.2]
  def change
    add_column :sections, :graders_required, :integer
  end
end
