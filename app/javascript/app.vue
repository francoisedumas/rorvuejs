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