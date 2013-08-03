require 'spec_helper'
require 'static_pages_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { get root_path }

    it { response.status.should be(200) }

    before { visit root_path }

    let(:heading)    { 'Welcome to Fit Tracker' }
    let(:page_title) { '' }
    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:sheet, user: user, date: Date.today - 2)
        FactoryGirl.create(:sheet, user: user, date: Date.today)
        exec_signin user
        visit root_path
      end

      it { should have_link('New', href: new_sheet_path) }


      it "should render the user's sheets table" do
        has_table?('userSheetsTable')
        user.sheets.each do |sheet|
          should have_xpath("//input[@type='hidden' and @value='#{sheet.id}']")
        end
      end

      it "should render the user's calendar" do
        has_selector?('calendar')
        (1..user.sheets.count).each do |i|
          has_xpath?("//span[@class='fc-event-title' and text()='Day #{i}']")
        end
      end

      #11.19
      #     describe ", 11.19 follower/following counts" do
      #       let(:other_user) { FactoryGirl.create(:user) }
      #       before do
      #         other_user.follow!(user)
      #         visit root_path
      #       end

      #       it { should have_link("0 following", href: following_user_path(user)) }
      #       it { should have_link("1 followers", href: followers_user_path(user)) }
      #     end

    end
  end

  describe "About page" do
    before { get about_path }

    it { response.status.should be(200) }

    before { visit about_path }

    let(:heading)    { 'About' }
    let(:page_title) { 'About Me' }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { get contact_path }

    it { response.status.should be(200) }

    before { visit contact_path }

    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact Me' }
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Me')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact Me')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    # click_link "sample app"
    # page.should # fill in
  end
end