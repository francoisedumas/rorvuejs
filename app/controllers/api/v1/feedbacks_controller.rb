module Api
  module V1
    class FeedbacksController < ApplicationController
      before_action :set_feedback, only: [:update, :destroy]

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

      # DELETE /feedbacks/1
      def destroy
        @feedback.destroy
      end

      # PATCH/PUT /feedbacks/1
      def update
        if @feedback.update(feedback_params)
          render json: @feedback
        else
          render json: @feedback.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_feedback
        @feedback = Feedback.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def feedback_params
        params.require(:feedback).permit(:title, :description, :rating)
      end
    end
  end
end
