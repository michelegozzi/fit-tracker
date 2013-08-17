# WARNING: You may need to restart your server (or spork)
# for the changes to be reflected

FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}" } 
		sequence(:email) { |n| "Person_#{n}@test.org" } 
		password "p4ssw0rd"
		password_confirmation "p4ssw0rd"
		factory :admin do
			#admin true
			after(:create) { |user| user.toggle!(:admin) }
		end
	end

	factory :sheet do
		calorie_target 100
		date { Date.today }
		week_num 1
		energy_level 6
		goals_met true
		notes { Faker::Lorem.sentence(5) }
		sleep_hours 7
		water_glasses 6
		user
	end
end