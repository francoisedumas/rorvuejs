module Api
  module V1
    class FeedbacksController < ApplicationController

      # GET /feedbacks
      def index
        @feedbacks = Feedback.all

        render json: @feedbacks
      end

      # POST /feedbacks
      def create
        @feedback = Feedback.new(feedback_params)

        if @feedback.save
          render json: @feedback, status: :created
        else
          render json: @feedback.errors, status: :unprocessable_entity
        end
      end

      private

      # Only allow a trusted parameter "white list" through.
      def feedback_params
        params.require(:feedback).permit(:title, :description)
      end
    end
  end
end