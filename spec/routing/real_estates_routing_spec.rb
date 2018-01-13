require "rails_helper"

RSpec.describe RealEstatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/real_estates").to route_to("real_estates#index")
    end

    it "routes to #show" do
      expect(:get => "/real_estates/1").to route_to("real_estates#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/real_estates").to route_to("real_estates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/real_estates/1").to route_to("real_estates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/real_estates/1").to route_to("real_estates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/real_estates/1").to route_to("real_estates#destroy", :id => "1")
    end

  end
end
