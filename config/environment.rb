# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FitTracker::Application.initialize!

Rails.logger = Logger.new(STDOUT)
Rails.logger.level = 0 # 0:debug, 1:info, 2:warn, 3:error, 4:fatal

if ENV['RAILS_ENV'] == "production"
  ActiveSupport::Deprecation.silenced = true
end
