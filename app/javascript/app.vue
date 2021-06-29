<template>
  <div id="app">
    <div class="banner" style="background-image: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)), url(https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/background.png);">
      <h1>{{ message }}</h1>
    </div>
    <FeedbacksList />
  </div>
</template>

<script>
import FeedbacksList from './components/FeedbacksList.vue'

export default {
  data: function () {
    return {
      message: "Hello! Below you will find the feedbacks"
    }
  },
  components: {
    FeedbacksList
  }
}
</script>

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
</style>
