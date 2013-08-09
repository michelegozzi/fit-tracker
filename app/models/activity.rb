ActiveRecord::MissingAttributeError = ActiveModel::MissingAttributeError unless defined?(ActiveRecord::MissingAttributeError)

# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  time       :datetime
#  duration   :integer
#  intensity  :integer
#  sheet_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#

class Activity < ActiveRecord::Base
	attr_accessible :name, :time, :duration, :intensity, :category	#, :sheet_id

  # Timepart attribute accessor needed to handle jquery-ui or bootstrap timepicker
	attr_accessor :timepart
  # Timepart attribute needed to handle jquery-ui or bootstrap timepicker
	attr_accessible :timepart

	belongs_to :sheet

	#def initialize(params={})
   	#	super(params)
  	#end

  # Activity categories
	CATEGORIES = [['fitness_class', 1], ['other', 2]]

  # Workout intensity level.
  # It assumes the following values:
  # 1. low
  # 2. medium
  # 3. high
	INTENSITY_LEVEL = [['low', 1], ['medium', 2], ['high', 3]]

	validates :name, presence: true, length: { maximum: 50 }
	validates :time, presence: true
	validates :duration,
		presence: true,
		:numericality => {
			:only_integer => true,
			:greater_than => 0
		}
	validates :intensity,
		presence: true,
		:numericality => {
			:only_integer => true,
			:greater_than => 0,
			:less_than_or_equal_to => 3
		}
	validates :category,
		presence: true,
		:numericality => {
			:only_integer => true,
			:greater_than => 0
		}

	after_initialize :set_timepart

	private
		def set_timepart
			logger.debug "DBG_20130619_0816 after_initialize"
			if self.time.nil?
				self.timepart = Time.local(2000, 1, 1).strftime("%I:%M %p")
			else
				self.timepart = self.time.strftime("%I:%M %p")
			end

		rescue ActiveRecord::MissingAttributeError
		end

end
