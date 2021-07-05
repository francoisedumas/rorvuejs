require 'rails_helper'

RSpec.describe "API V1 Feedback", type: 'request' do

  describe "POST /api/v1/feedback" do
    context "with valid parameters" do
      let(:valid_params) do
        {
           feedback: {
            title: "Post title",
            description: "Post description"
          }
        }
      end

      it "creates a new feedback" do
        expect { post '/api/v1/feedbacks', params: valid_params }.to change(Feedback, :count).by(+1)
        pp response
        expect(response).to have_http_status :created
      end

      it "creates a feedback with the correct attributes" do
         post "/api/v1/feedbacks", params: valid_params
         expect(Feedback.last).to have_attributes valid_params[:feedback]
      end
    end

    # context "with invalid parameters" do
    #    # TO DO
    #    # ...
    # end
  end
end