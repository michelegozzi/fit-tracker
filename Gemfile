source 'https://rubygems.org'
ruby "1.9.3"
#source 'vendor/cache'

gem 'rails', '3.2.11'
gem 'therubyracer'
gem 'rspec'
gem 'sass', '~> 3.2'
#gem 'bootstrap-sass', '~> 2.3.1.2' #'2.1'
#gem 'bcrypt-ruby'#, '3.0.1'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'faker', '1.0.1'              #9.29
gem 'will_paginate', '3.0.3'          #9.31
#gem 'bootstrap-will_paginate', '0.0.6'     #9.31
gem 'jquery-rails'
gem 'debugger', group: [:development, :test]
gem 'json'
#gem 'safe_attributes'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails'
	gem 'spork'
  gem 'guard-rspec'
  gem 'guard-spork'
	gem 'annotate', '2.5.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails',   '~> 3.2.3'
	gem 'coffee-rails', '~> 3.2.1'

	# See https://github.com/sstephenson/execjs#readme for more supported runtimes
	# gem 'therubyracer', :platforms => :ruby

	gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'capybara'
	gem 'rb-inotify'
	gem 'libnotify'
	gem 'factory_girl_rails'
	gem 'database_cleaner', '0.7.0'
	gem 'cucumber-rails', :require => false

  gem 'thor' # (>= 0.14.6)
  gem 'lumberjack' # (>= 1.0.2)
  gem 'rb-inotify' # (>= 0.9)
  gem 'ffi' # (>= 0.5.0)


end

group :production do
	gem 'pg', '0.12.2'
end
