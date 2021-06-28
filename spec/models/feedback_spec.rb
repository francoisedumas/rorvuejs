require 'rails_helper'

RSpec.describe Feedback, type: :model do
  subject(:my_feedback) {
    Feedback.create(
      title: "That's a title",
      description: "And this is a description"
    )
  }

  it 'is created' do
    expect(my_feedback).to be_valid
  end

  it 'can be checked for object attribute and proper values' do
    expect(my_feedback).to have_attributes(title: "That's a title", description: "And this is a description")
  end
end
