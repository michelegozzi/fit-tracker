class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.integer :calories_target
      t.datetime :date
      t.integer :week_num
      t.integer :day
      t.integer :water_glasses
      t.integer :sleep_hours
      t.string :notes
      t.boolean :goals_met
      t.integer :energy_level
      t.integer :user_id

      t.timestamps
    end
  end
end
