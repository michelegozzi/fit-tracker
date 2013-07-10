ENV["RAILS_ENV"] ||= 'test'

# Conditional Spork.prefork (this comment is needed to fool Spork's `bootstrapped?` check)
if /spork/i =~ $0 || RSpec.configuration.drb?
  require File.expand_path("../spec_helper_spork", __FILE__)
else
  require File.expand_path("../spec_helper_base", __FILE__)
end