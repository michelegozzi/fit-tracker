class RenameIntensityForActivities < ActiveRecord::Migration
	def change
		rename_column :activities, :level, :intensity
	end
end
