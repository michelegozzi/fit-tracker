# WARNING: You may need to restart your server (or spork)
# for the changes to be reflected

FactoryGirl.define do
	factory :user do
		#9.32
		sequence(:name) { |n| "Person #{n}" } 
		sequence(:email) { |n| "Person_#{n}@test.org" } 
		password "p4ssw0rd"
		password_confirmation "p4ssw0rd"

		#9.43
		factory :admin do
			#admin true
			after(:create) { |user| user.toggle!(:admin) }
		end
	end

	#10.12
	factory :micropost do
		content "Lorem ipsum"
		user
	end
end