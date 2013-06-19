class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.datetime :time
      t.integer :duration
      t.integer :level
      t.integer :sheet_id

      t.timestamps
    end
  end
end
