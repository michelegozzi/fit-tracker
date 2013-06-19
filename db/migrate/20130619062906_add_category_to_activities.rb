class AddCategoryToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :category, :integer
  end
end
