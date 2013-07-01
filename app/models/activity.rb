class Activity < ActiveRecord::Base
	attr_accessible :name, :time, :duration, :intensity, :category	#, :sheet_id

	attr_accessor :timepart
	attr_accessible :timepart

	belongs_to :sheet

	CATEGORIES = [['turbofire_class', 1], ['other', 2]]
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

	after_initialize do |activity|
		logger.debug "DBG_20130619_0816 after_initialize"
		if activity.time.nil?
			activity.timepart = Time.local(2000, 1, 1).strftime("%I:%M %p")
		else
			activity.timepart = activity.time.strftime("%I:%M %p")
		end
	end

end