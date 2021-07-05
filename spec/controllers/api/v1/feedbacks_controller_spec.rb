require 'rails_helper'

RSpec.describe Api::V1::FeedbacksController do
  let!(:first_feedback)  { Feedback.create(:title => "Test Title", :description => "Test Description")}

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

  # describe "POST #create" do
  #   let!(:params) { {feedback: { title: "Post title", description: "Post description" } } }

  #   it "receives info data and creates a new feedback" do
  #     post :create, params: params
  #     expect(post :create, params: params).to change(Feedback, :count).by(1)
  #   end
  # end
end
