source 'https://rubygems.org'
#source 'vendor/cache'

gem 'rails', '3.2.11'
gem 'therubyracer'
gem 'rspec'
gem 'sass', '~> 3.2'
gem 'bootstrap-sass', '~> 2.3.1.2'	#'2.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1'							#9.29
gem 'will_paginate', '3.0.3'					#9.31
gem 'bootstrap-will_paginate', '0.0.6'			#9.31
gem 'jquery-rails'
gem 'debugger', group: [:development, :test]
gem 'json'

	
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails', '2.11.0'
	gem 'guard-rspec', '1.2.1'
	gem 'guard-spork', '1.2.0'
	gem 'spork', '0.9.2'
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
	gem 'capybara', '1.1.2'
	#gem 'rb-inotify', '0.8.8'
	#gem 'libnotify', '0.5.9'
	gem 'factory_girl_rails', '4.1.0'
	gem 'database_cleaner', '0.7.0'
	gem 'cucumber-rails', '1.2.1', :require => false
end

group :production do
	gem 'pg', '0.12.2'
end
