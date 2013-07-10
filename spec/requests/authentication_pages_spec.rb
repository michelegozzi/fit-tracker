require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page" do
		before { get signin_path }

		it { response.status.should be(200) }

		before { visit signin_path }

		it { should have_selector('h1', text: 'Sign in') }
		it { should have_selector('title', text: 'Sign in') }

	end

	describe "signin" do
		before { visit signin_path }

		let(:submit) { "Sign in" }

		describe "with invalid information" do

			before { click_button submit }

			it { should have_selector('title', text: 'Sign in') }
			it { should have_error_message('Invalid') }	#defined in utilities.rb
			
			
			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }

			#9.6 Exercise 3
			describe "before providing valid signin information" do
				it { should_not have_selector('Profile') }
				it { should_not have_selector('Settings') }
			end

			before { valid_signin user} #defined in utilities.rb

			it { should have_selector('title', text: user.name) }

			it { should have_link('Users', href: users_path) } #9.27
			it { should have_link('Profile', href: user_path(user)) }
			it { should have_link('Settings', href: edit_user_path(user)) }
			it { should have_link('Sign out', href: signout_path) }
			
			it { should_not have_link('Sign in', href: signin_path) }

			#9.6 Exercise 6
			describe "for signed in users new action is avoided" do
				before { get new_user_path }
				#from rake routes:
				#new_user GET    /users/new(.:format)       users#new
				specify { response.should redirect_to(root_path) }
			end
			#9.6 Exercise 6
			describe "for signed in users create action is avoided" do
				before { post users_path }
				#from rake routes:
				#POST   /users(.:format)           users#create
				specify { response.should redirect_to(root_path) }
			end

			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end

		end
	end

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			#10.26
			describe "10.26 in the Microposts controller" do
				describe "10.26 submitting to the create action" do
					before { post microposts_path }
					specify { response.should redirect_to(signin_path) }
				end

				describe "10.26 submitting to the destroy action" do
					before { delete micropost_path(FactoryGirl.create(:micropost)) }
					specify { response.should redirect_to(signin_path) }
				end
			end

			#9.17
			describe "9.17 for non-signed-in users" do
				before do
					visit edit_user_path(user)
					valid_signin user
					#exec_signin user
				end

				describe "after signing in" do
					it "should render the desired protected page" do
						page.should have_selector('title', text: 'Edit user')
					end
				end
			end


			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_selector('title', text: 'Sign in') }
				end

				describe "submitting to the update action" do
					before { put user_path(user) }
					specify { response.should redirect_to(signin_path) }
				end
				#9.21
				describe "visiting the user index" do
					before { visit users_path }
					it { should have_selector('title', text: 'Sign in') }
				end


				#11.28
				describe ", 11.28 visiting the following page" do
					before { visit following_user_path(user) }
					it { should have_selector('title', text: 'Sign in') }
				end

				describe ", 11.28 visiting the followers page" do
					before { visit followers_user_path(user) }
					it { should have_selector('title', text: 'Sign in') }
				end

			end

			#9.6 Exercise 8
			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email",    with: user.email
					fill_in "Password", with: user.password
					click_button "Sign in"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						page.should have_selector('title', text: 'Edit user')
					end

					describe "when signing in again" do
						before do
							delete signout_path
							visit signin_path
							fill_in "Email",    with: user.email
							fill_in "Password", with: user.password
							click_button "Sign in"
						end

						it "should render the default (profile) page" do
							page.should have_selector('title', text: user.name) 
						end
					end
				end
			end

			#11.33
			describe ", 11.33 in the Relationships controller" do
				describe "submitting to the create action" do
					before { post relationships_path }
					specify { response.should redirect_to(signin_path) }
				end

				describe ", 11.33 submitting to the destroy action" do
					before { delete relationship_path(1) }
					specify { response.should redirect_to(signin_path) }          
				end
			end



		end

		#9.14
		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@email.org") }
			before do
				#visit signin_path
				#valid_signin user
				exec_signin user
			end

			describe "visiting Users#edit page" do
				before { visit edit_user_path(wrong_user) }
				it { should_not have_selector('title', text: full_title('Edit user')) }
			end

			describe "submitting a PUT request to the Users#update action" do
				before { put user_path(wrong_user) }
				specify { response.should redirect_to(root_path) }
			end
		end

		#9.47
		describe "as non-admin user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) { FactoryGirl.create(:user) }

			before { exec_signin non_admin }

			describe "submitting a DELETE request to the Users#destroy action" do
				before { delete user_path(user) }
				specify { response.should redirect_to(root_path) }        
			end
		end

		describe "as admin user" do
			let!(:user) { FactoryGirl.create(:user) }
			let!(:admin) { FactoryGirl.create(:admin) }

			before { exec_signin admin }

			describe "submitting a DELETE request to the Users#destroy action" do
				it "not expecting an user decrement for himself" do
					expect { delete user_path(admin) }.not_to change(User, :count).by(-1)
				end

				it "expecting an user decrement for a different user" do
					expect { delete user_path(user) }.to change(User, :count).by(-1)
				end
			end

			describe "submitting a DELETE request to the Users#destroy action" do
				        
			end
		end

	end	
end