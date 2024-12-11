class ChangeGradersRequiredDefaultToOneInSections < ActiveRecord::Migration[7.2]
  def change
    change_column_default :sections, :graders_required, from: nil, to: 1
  end
end
