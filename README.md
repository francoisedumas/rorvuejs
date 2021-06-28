### RoR / Vue.js Workshop
## Introduction to Vue.js using Ruby on Rails for the back
The target is to build a simple feedback application using 
 - RoR as an API back end
 - Vue.js for the front end

## Starting with API back end

### Rails new
Let's start by creating a new Rails app calling Vue.js with Webpack
```
# In the terminal
rails new rorvuejs --webpack=vue --database=postgresql

cd rorvuejs
git add . && git commit -m "My new RoR-Vue.js app"
gh repo create
git push origin master
```

### Creating the DB
```
# In the terminal
rails db:create
rails db:migrate RAILS_ENV=development
```

### Home page: route and controller
In order to call our front with Vue.js we will create a home page
```
# In the terminal
rails generate controller Home index

# config/routes.rb replace GET home route by below one
root to: 'home#index'

# in app/views/home/index.html replace all by
<div id='app'></div>
```

### Generating the feedback model
```
# In the terminal
rails g model Feedback title:string description:text
rails db:migrate
rails g controller feedbacks
```

### API: routes & controllers
Now we will create the structure of our app for the API
```
# in routes.rb
namespace :api do
  namespace :v1 do      
    resources :feedbacks
  end
end

# build the next folder structure for controllers
/controllers
    /api
        /v1
# then move the feedback controller inside
```

### Feedback controller
In your Feedback controller file add
```
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
```

### Seeds
Let's create some data with your seeds file
```
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

# In the terminal
rails db:seed
```

### Accessing the API
Now lets visualize the api
Start a server with rails s
Go to http://localhost:3000/api/v1/feedbacks
