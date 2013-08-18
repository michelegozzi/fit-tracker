require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "index" do

		let(:user) { FactoryGirl.create(:user) }
		
		before(:each) do
			#visit signin_path
			#valid_signin user
			exec_signin user
			visit users_path

      it "should redirect to the home page" do
        current_path.should == root_path
        #response.should redirect_to(root_path)
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
		
		#let!(:s1) { FactoryGirl.create(:sheet, user: user, ...) } #TODO
		#let!(:s2) { FactoryGirl.create(:sheet, user: user, ...) } #TODO

		before { visit user_path(user) }

		#it { should have_selector('h4', text: user.name) }
		it { should have_selector('title', text: user.name) }

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
			it { should have_content('Password confirmation can\'t be blank') }
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "My Name"
				fill_in "Email", with: "myname@mymail.org"
				fill_in "Password", with: "p4ssw0rd"
				fill_in "Confirm Password", with: "p4ssw0rd"
			end			

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by_email('myname@mymail.org') }

				it { should have_selector('title', text: user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
				it { should have_link('Sign out') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
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

		describe "with valid information" do
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
end