# == Schema Information
#
# Table name: sheets
#
#  id              :integer          not null, primary key
#  calories_target :integer
#  date            :datetime
#  week_num        :integer
#  day             :integer
#  water_glasses   :integer
#  sleep_hours     :integer
#  notes           :string(255)
#  goals_met       :boolean
#  energy_level    :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Sheet < ActiveRecord::Base
	attr_accessible :calorie_target, :date, :day, :energy_level, :goals_met, :notes, :sleep_hours, :water_glasses, :week_num, :total_calories_consumed, :meals_attributes, :activities_attributes

	has_many :meals, :dependent => :destroy
	has_many :activities, :dependent => :destroy

	accepts_nested_attributes_for :meals, :allow_destroy => true
	accepts_nested_attributes_for :activities, :allow_destroy => true

	belongs_to :user

	NOTES_MAXIMUM = 255
	SLEEP_HOURS = Array(0..24)	# or (0..24).to_a
	GOALS_MET = [['Yes', 1], ['No', 0]]


	validates :calorie_target, presence: true
	validates :date, presence: true, uniqueness: true
	#:week_num
	#:day
	validates :water_glasses,
		presence: true,
		:numericality => {
			:only_integer => true,
			:greater_than_or_equal_to => 0,
			:less_than_or_equal_to => 8
		}
	validates :sleep_hours,
		presence: true,
		:numericality => {
			:only_integer => true,
			:greater_than_or_equal_to => 0,
			:less_than_or_equal_to => 24
		}
	validates :notes, length: { maximum: NOTES_MAXIMUM }
	validates :goals_met, presence: true
	validates :energy_level, presence: true

	before_save :update_total_calories_consumed

	private
		
		def update_total_calories_consumed
			#debugger
			
			if self.meals.any?
				total_calories_consumed = 0
				self.meals.each { |m| total_calories_consumed += m.calories }
				self.total_calories_consumed = total_calories_consumed

				logger.debug "DBG_20130612_2000 update_total_calories_consumed: #{self.total_calories_consumed}"
			end

			debugger
		end
end
