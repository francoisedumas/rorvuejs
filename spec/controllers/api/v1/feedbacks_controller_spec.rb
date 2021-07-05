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

  describe "POST #create" do
    let!(:params) { {feedback: { title: "Feedback title", description: "Feedback description", rating: 4} } }

    before do
      post :create, params: params
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "receives info data and creates the new feedback" do
      expect(Feedback.last).to have_attributes params[:feedback]
    end

    # it "adds a new feedback" do
    #   expect(post :create, params: params).to change(Feedback, :count).by(1)
    # end
  end

  describe "DELETE #destroy" do

    before do
      feedback_to_destroy = Feedback.create(title: "Feedback to destroy", description: "Feedback to destroy", rating: 4)
      @total_feedback = Feedback.count
      delete :destroy, params: { id: feedback_to_destroy.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "removes the last feedback created" do
      # should be done with .to change but...
      new_total_feedback = Feedback.count
      expect(@total_feedback).not_to eq(new_total_feedback)
    end
  end
end
