require 'spec_helper'

describe "Admin pages" do

  subject { page }

  describe "index" do

    let(:admin) { FactoryGirl.create(:admin) }
    
    before(:each) do
      #visit signin_path
      #valid_signin user
      exec_signin admin
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      before(:all) { 31.times { FactoryGirl.create(:admin) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.fit-pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should have_link('delete', href: user_path(User.last)) }
      it "should be able to delete another user" do
        expect { click_link('delete') }.to change(User, :count).by(-1)
      end
      it { should_not have_link('delete', href: user_path(admin)) }
    end
  end

  
end