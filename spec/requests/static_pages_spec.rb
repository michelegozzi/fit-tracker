require 'spec_helper'
require 'static_pages_helper'

describe "StaticPages" do

	# let(:base_title) { "Rails Example" }


	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1',    text: heading) }
		it { should have_selector('title', text: full_title(page_title)) }
	end

	describe "Home page" do
		before { get root_path }

		it { response.status.should be(200) }

		before { visit root_path }

		let(:heading)    { 'Welcome to Rails Example' }
		let(:page_title) { '' }
		it_should_behave_like "all static pages"
		it { should_not have_selector 'title', text: '| Home' }

		#10.40
		describe "10.40 for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				exec_signin user
				visit root_path
			end

			it "10.40 should render the user's feed" do
				user.feed.each do |item|
					page.should have_selector("li##{item.id}", text: item.content)
				end
			end

			#11.19
			describe ", 11.19 follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end

				it { should have_link("0 following", href: following_user_path(user)) }
				it { should have_link("1 followers", href: followers_user_path(user)) }
			end

		end
	end

	describe "About page" do
		before { get about_path }

		it { response.status.should be(200) }

		before { visit about_path }

		let(:heading)    { 'About Rails Example' }
		let(:page_title) { 'About Us' }
		it_should_behave_like "all static pages"
	end

	describe "Contact page" do
		before { get contact_path }

		it { response.status.should be(200) }

		before { visit contact_path }

		let(:heading)    { 'Contact Rails Example' }
		let(:page_title) { 'Contact' }
		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		page.should have_selector 'title', text: full_title('About Us')
		click_link "Contact"
		page.should have_selector 'title', text: full_title('Contact')
		click_link "Home"
		click_link "Sign up now!"
		page.should have_selector 'title', text: full_title('Sign up')
		# click_link "sample app"
		# page.should # fill in
	end
  
	
end

