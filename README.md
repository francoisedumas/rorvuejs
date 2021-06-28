# RoR / Vue.js Workshop
## Introduction to Vue.js using Ruby on Rails for the back
The target is to build a simple feedback application using 
 - RoR as an API back end
 - Vue.js for the front end

<img width="1262" alt="Screenshot_app_result" src="https://user-images.githubusercontent.com/33062224/123646517-93cde300-d827-11eb-9f45-accf7cfd5708.png">

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

## Working with Vue.js for the front

### Adding static page with Vue.js

```
# app/view/application.html.erb add
<%= javascript_pack_tag 'hello_vue' %>

# In the terminal open 2 windows and run below command
# in one tab
rails server

# in another tab
./bin/webpack-dev-server

```

### Connexion between API and front with AXIOS

```
# In your below structure
/javacript
    /packs
				hello_vue.js
				application.js
		app.vue
add a folder api and create a file client.js
/javacript
    /packs
				  /api
        client.js
```
In this client.js file we will add the connexion with the API
```
# In the app/javascript/packs/api/client.js add
import axios from 'axios';

const API_URL = 'http://localhost:3000'

export const apiClient = axios.create({
  // baseURL:          window.location.origin,
  baseURL: API_URL,
  headers:          {
    Accept:         'application/json',
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.getElementsByName("csrf-token")[0].getAttribute("content")
  },
  timeout:          30000
});

export const api = {
  feedbacks() {
    return apiClient.get(`/api/v1/feedbacks`);
  }
}
```

### Creating our first Vue.js component

```
# In your app.vue file
<template>
  <div id="app">
    <div class="banner" style="background-image: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)), url(https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/background.png);">
      <h1>{{ message }}</h1>
    </div>
    <ul class="mt-4">
      <li class="card-product" v-for="feedback in feedbacks" :key="feedback.id" :feedback="feedback">
        <img src="https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/skateboard.jpg" />
        <div class="card-product-infos">
          <h2>{{ feedback.title }}</h2>
          <p>{{ feedback.description }}</p>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import { api } from './packs/api/client';
export default {
  data: function () {
    return {
      message: "Hello! Below you will find the feedbacks",
      feedbacks: []
    }
  },
  mounted() {
    this.loadFeedback();
  },
  methods: {
    loadFeedback() {
      return api.feedbacks().then((response) => {
        this.feedbacks = response.data;
      });
    }
  }
}
</script>
```

Go to http://localhost:3000/api/v1/feedbacks
You will see your feedbacks displayed!
Now let's add some style


```

<style scoped>
.banner {
  background-size: cover;
  background-position: center;
  padding: 150px 0;
}

.banner h1 {
  margin: 0;
  color: white;
  text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
  font-size: 32px;
  font-weight: bold;
  text-align: center;
}

.card-product {
  overflow: hidden;
  height: 120px;
  background: white;
  box-shadow: 0 0 15px rgba(0,0,0,0.2);
  display: flex;
  align-items: center;
  margin: 5px;
}

.card-product img {
  height: 100%;
  width: 120px;
  object-fit: cover;
}

.card-product h2 {
  font-size: 16px;
  font-weight: bold;
  margin: 0;
}

.card-product p {
  font-size: 12px;
  line-height: 1.4;
  opacity: .7;
  margin-bottom: 0;
  margin-top: 8px;
}

.card-product .card-product-infos {
  padding: 16px;
}
</style>
```

### Adding some tests 😇

```
# in the Gemfile
group :development, :test do
  gem 'rspec-rails'
end

# in the terminal
bundle
rails generate rspec:install
```
Ready! Let's test the feedback model
```
# In the terminal
rails generate rspec:model feedback
# in the file spec/models/feedback_spec.rb
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

# in the terminal run
rspec spec/models/feedback_spec.rb
```

Now lets test the API!!
To come later 😂
