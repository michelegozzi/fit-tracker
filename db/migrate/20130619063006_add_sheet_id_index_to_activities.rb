class AddSheetIdIndexToActivities < ActiveRecord::Migration
  def change
  	add_index :activities, :sheet_id
  end
end
