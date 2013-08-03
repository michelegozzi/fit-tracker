require 'spec_helper'

describe Admin::FoodsController do

  

#  upload_admin_foods POST   /admin/foods/upload(.:format)   admin/foods#upload
#search_admin_foods GET    /admin/foods/search(.:format)   admin/foods#search
#       admin_foods GET    /admin/foods(.:format)          admin/foods#index
                   #POST   /admin/foods(.:format)          admin/foods#create


  describe "POST 'upload'" do
    it "should redirect to root path" do
      post 'upload'
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'search'" do
    it "should redirect to root path" do
      get 'search'
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'index'" do
    it "should redirect to root path" do
      get 'index'
      response.should redirect_to(root_path)
    end
  end

  describe "POST 'create'" do
    it "should redirect to root path" do
      post 'create'
      response.should redirect_to(root_path)
    end
  end

   # new_admin_food GET    /admin/foods/new(.:format)      admin/foods#new
   #edit_admin_food GET    /admin/foods/:id/edit(.:format) admin/foods#edit
        #admin_food GET    /admin/foods/:id(.:format)      admin/foods#show

  describe "GET 'new'" do
    it "should redirect to root path" do
      get 'new'
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'edit'" do
    it "should redirect to root path" do
      get 'edit', :id => 0
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'show'" do
    it "should redirect to root path" do
      get 'show', :id => 0
      response.should redirect_to(root_path)
    end
  end

#  PUT    /admin/foods/:id(.:format)      admin/foods#update
#  DELETE /admin/foods/:id(.:format)      admin/foods#destroy

  describe "PUT 'update'" do
    it "should redirect to root path" do
      put 'update', :id => 0
      response.should redirect_to(root_path)
    end
  end

  describe "DELETE 'destroy'" do
    it "should redirect to root path" do
      delete 'destroy', :id => 0
      response.should redirect_to(root_path)
    end
  end

end
