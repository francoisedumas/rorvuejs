<template>
  <div id="app">
    <div class="banner" style="background-image: linear-gradient(rgba(0,0,0,0.2),rgba(0,0,0,0.2)), url(https://source.unsplash.com/random);">
      <h1><span class="vhs-title" id="vhs-title"></span></h1>
    </div>
    <FeedbacksList />
  </div>
</template>

<script>
import FeedbacksList from './components/FeedbacksList.vue'

export default {
  data: function () {
    return {
      message: "Find here the best movies' feedbacks!"
    }
  },
  components: {
    FeedbacksList
  }
}
</script>
