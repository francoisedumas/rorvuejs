# Cleaning DB
puts "Cleaning Database"
Feedback.destroy_all
# Creating feedbacks
puts "Creating feedbacks"
Feedback.create!(title: "My feedback", description: "This first feedback is awesome", rating: 5)
Feedback.create!(title: "My second feedback", description: "This second feedback will follow", rating: 3)
Feedback.create!(title: "1 last thing", description: "More to come...", rating: 1)
# Feedback created
puts "Feedbacks created"
