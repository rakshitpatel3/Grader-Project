class AddApprovedToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :approved, :boolean
  end
end
