# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FitTracker::Application.initialize!

if ENV['RAILS_ENV'] == "production"
  ActiveSupport::Deprecation.silenced = true
end