require 'spec_helper'

describe Helpers::FoodsController do

  describe "GET 'index'" do
    it "returns http success" do
      visit helpers_foods_path
      response.should be_success
    end
  end

end
