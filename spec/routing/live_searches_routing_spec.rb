require "rails_helper"

RSpec.describe LiveSearchesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/live_searches").to route_to("live_searches#index")
    end

    it "routes to #new" do
      expect(:get => "/live_searches/new").to route_to("live_searches#new")
    end

    it "routes to #show" do
      expect(:get => "/live_searches/1").to route_to("live_searches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/live_searches/1/edit").to route_to("live_searches#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/live_searches").to route_to("live_searches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/live_searches/1").to route_to("live_searches#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/live_searches/1").to route_to("live_searches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/live_searches/1").to route_to("live_searches#destroy", :id => "1")
    end
  end
end
