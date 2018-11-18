require 'rails_helper'

RSpec.describe "LiveSearches", type: :request do
  describe "GET /live_searches" do
    it "works! (now write some real specs)" do
      get live_searches_path
      expect(response).to have_http_status(200)
    end
  end
end
