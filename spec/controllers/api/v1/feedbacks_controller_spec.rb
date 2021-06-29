require 'rails_helper'

RSpec.describe Api::V1::FeedbacksController do
  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected feedback attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.first.keys).to include("id", "title", "description")
    end
  end
end
