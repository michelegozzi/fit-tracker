class AddIndexesToSheets < ActiveRecord::Migration
  def change
  	add_index :sheets, :user_id
  	add_index :sheets, [:date, :user_id], unique: true
  end
end
