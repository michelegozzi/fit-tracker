# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  time       :datetime
#  calories   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  sheet_id   :integer
#

class Meal < ActiveRecord::Base
	attr_accessible :calories, :name, :category, :time, :daytime

	attr_accessor :timepart
	attr_accessible :timepart

	#attr_accessor_with_default :timepart, Date.new.strftime("%I:%M %p")

	belongs_to :sheet

	CATEGORIES = [['breakfast', 1], ['snack1', 2], ['lunch', 3], ['snack2', 4], ['dinner', 5]]



	validates :name, presence: true, length: { maximum: 50 }
	validates :calories,
		presence: true,
		:numericality => {
			:only_integer => true,
			:greater_than => 0
		}
	validates :time, presence: true
	validates :category,
		presence: true,
		:numericality => {
			:only_integer => true,
			:greater_than => 0
		}



	before_save do |meal|
		logger.debug "DBG_20130612_1346 before_save"
		#meal.calories += 1
		#meal.time = Time.zone.parse(meal.timepart)
		#logger.debug meal.timepart.to_s
		#logger.debug meal.time.to_s
	end

	before_save :parse_categories
	after_initialize :parse_categories
	before_create :parse_categories
	before_validation :test_before_validation

	after_initialize do |meal|
		logger.debug "DBG_20130612_1345 after_initialize"
		if meal.time.nil?
			meal.timepart = Time.local(2000, 1, 1).strftime("%I:%M %p")
		else
			meal.timepart = meal.time.strftime("%I:%M %p")
		end
		#meal.datepart = Date.today.to_time

		#meal.time = Date.today.to_time
	end

	private
		def test_before_validation
			logger.debug "DBG_20130612_2246 test_before_validation: #{self.category}"
		end

		def parse_categories
			#debugger
			logger.debug "DBG_20130612_2000 parse_categories: #{self.category}"
			item = Meal::CATEGORIES.select {|c| c.include?(self.category.to_s)}

			if item.any?
				self.category = item[0][1].to_i
			end

			self.category = self.category.to_i
			#debugger

			#CATEGORIES.select {|a| a.include?(self.category) }

			#self.category = SecureRandom.urlsafe_base64
		end
end
