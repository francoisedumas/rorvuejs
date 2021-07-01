class AddRatingToFeedback < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :rating, :integer
  end
end
