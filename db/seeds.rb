# Cleaning DB
puts "Cleaning Database"
Feedback.destroy_all
# Creating feedbacks
puts "Creating feedbacks"
Feedback.create!(title: "My feedback", description: "This first feedback will be displayed soon")
Feedback.create!(title: "My second feedback", description: "This second feedback will follow")
Feedback.create!(title: "1 last thing", description: "More to come...")
# Feedback created
puts "Feedbacks created"
