require 'spec_helper'

describe "User pages" do

	subject { page }

	#9.23 -> 9.33
	describe "9.33 index" do

		let(:user) { FactoryGirl.create(:user) }
		
		before(:each) do
			#visit signin_path
			#valid_signin user
			exec_signin user
			visit users_path
		end

		it { should have_selector('title', text: 'All users') }
		it { should have_selector('h1',    text: 'All users') }

		#9.33
		describe "9.33 pagination" do

			before(:all) { 31.times { FactoryGirl.create(:user) } }
			after(:all)  { User.delete_all }

			it { should have_selector('div.pagination') }

			it "9.33 should list each user" do
				User.paginate(page: 1).each do |user|
					page.should have_selector('li', text: user.name)
				end
			end
		end

		#9.44
		describe "9.44 delete links" do

			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
					exec_signin admin
					visit users_path
				end

				it { should have_link('delete', href: user_path(User.first)) }
				it "should be able to delete another user" do
					expect { click_link('delete') }.to change(User, :count).by(-1)
				end
				it { should_not have_link('delete', href: user_path(admin)) }
			end
		end
	end

	describe "signup page" do
		before { get signup_path }

		it { response.status.should be(200) }

		before { visit signup_path }

		it { should have_selector('h1',    text: 'Sign up') }
		it { should have_selector('title', text: full_title('Sign up')) }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		#10.19
		let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") } #10.19
		let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") } #10.19

		before { visit user_path(user) }

		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name) }

		#10.19
		describe "10.19 microposts" do
			it { should have_content(m1.content) }
			it { should have_content(m2.content) }
			it { should have_content(user.microposts.count) }
		end

		#11.32
		describe ", 11.32 follow/unfollow buttons" do
			let(:other_user) { FactoryGirl.create(:user) }
			before { exec_signin user }

			describe ", 11.32 following a user" do
				before { visit user_path(other_user) }

				it ", 11.32 should increment the followed user count" do
				expect do
					click_button "Follow"
					end.to change(user.followed_users, :count).by(1)
				end

				it ", 11.32 should increment the other user's followers count" do
					expect do
						click_button "Follow"
					end.to change(other_user.followers, :count).by(1)
				end

				describe ", 11.32 toggling the button" do
					before { click_button "Follow" }
					it { should have_selector('input', value: 'Unfollow') }
				end
			end

			describe ", 11.32 unfollowing a user" do
				before do
					user.follow!(other_user)
					visit user_path(other_user)
				end

				it ", 11.32 should decrement the followed user count" do
					expect do
						click_button "Unfollow"
					end.to change(user.followed_users, :count).by(-1)
				end

					it ", 11.32 should decrement the other user's followers count" do
					expect do
						click_button "Unfollow"
					end.to change(other_user.followers, :count).by(-1)
				end

				describe ", 11.32 toggling the button" do
					before { click_button "Unfollow" }
					it { should have_selector('input', value: 'Follow') }
				end
			end
		end
	end

	describe "signup" do
		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "after submission" do
			before { click_button submit }

			it { should have_selector('title', text: 'Sign up') }
			it { should have_content('error') }
			it { should have_content('Name can\'t be blank') }
			it { should have_content('Email can\'t be blank') }
			it { should have_content('Email is invalid') }
			it { should have_content('Password can\'t be blank') }
			it { should have_content('Password is too short (minimum is 6 characters)') }
			it { should have_content('Confirmation can\'t be blank') }
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "Michele Gozzi"
				fill_in "Email", with: "michelegozzi@gmail.com"
				fill_in "Password", with: "p4ssw0rd"
				fill_in "Confirm Password", with: "p4ssw0rd"
			end			

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by_email('michelegozzi@gmail.com') }

				it { should have_selector('title', text: user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
				it { should have_link('Sign out') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		#9.13
		before do
			#visit signin_path
			#valid_signin user
			exec_signin user
			visit edit_user_path(user)
		end

		describe "page" do
			it { should have_selector('h1', text: "Update your profile") }
			it { should have_selector('title', text: "Edit user") }
			it { should have_link('change', href: 'http://gravatar.com/emails') }
		end

		describe "with invalid information" do
			before { click_button "Save changes" }

			it { should have_content('error') }
		end

		#9.9
		describe "9.9 with valid information" do
			let(:new_name) { "New Name" }
			let(:new_email) { "new@test.org" }
			before do
				fill_in "Name", with: new_name
				fill_in "Email", with: new_email
				fill_in "Password", with: user.password
				fill_in "Confirm Password", with: user.password
				click_button "Save changes"
			end

			it { should have_selector('title', text: new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Sign out', href: signout_path) }
			specify { user.reload.name.should == new_name }
			specify { user.reload.email.should == new_email }
		end

	end

	#11.29
	describe ", 11.29 following/followers" do
		let(:user) { FactoryGirl.create(:user) }
		let(:other_user) { FactoryGirl.create(:user) }
		before { user.follow!(other_user) }

		describe ", 11.29 followed users" do
			before do
				exec_signin user
				visit following_user_path(user)
			end

			it { should have_selector('title', text: full_title('Following')) }
			it { should have_selector('h3', text: 'Following') }
			it { should have_link(other_user.name, href: user_path(other_user)) }
		end

		describe ", 11.29 followers" do
			before do
				exec_signin other_user
				visit followers_user_path(other_user)
			end

			it { should have_selector('title', text: full_title('Followers')) }
			it { should have_selector('h3', text: 'Followers') }
			it { should have_link(user.name, href: user_path(user)) }
		end
	end
end