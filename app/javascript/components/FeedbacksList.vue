<template>
  <div class="container">
    <div>
      <button class="btn btn-ghost" @click="newFeedbackVisible = !newFeedbackVisible">
        {{ newFeedbackVisible ? "✕" : "＋" }}
      </button>
      <div
        v-show="newFeedbackVisible"
        class="vhs-show-card container"
        @keyup.enter="addFeedback(newTitle, newDescription), resetForm()"
      >
        <input
          type="text"
          placeholder="Enter a title"
          v-model="newTitle"
        />
        <textarea
          placeholder="Enter a title"
          v-model="newDescription"
        ></textarea>
      </div>
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
import { api } from '../packs/api/client';

export default {
  data() {
    return {
      feedbacks: [],
      newFeedbackVisible: false,
      newDescription: "",
      newTitle: "",
    }
  },
  mounted() {
    this.loadFeedback();
  },
  methods: {
    loadFeedback() {
      return api.getFeedbacks().then((response) => {
        this.feedbacks = response.data;
      });
    },
    resetForm() {
      this.newDescription = ""
      this.newTitle = ""
    },
    addFeedback(title, description) {
      this.newFeedbackVisible = false;
      return api.postFeedbacks(title, description).then((response) => {
        this.feedbacks.push(response.data)
        this.newTitle = ""
        this.newDescription = ""
      })
    }
  },
}
</script>


<style scoped>
.container {
  display: flex;
  flex-direction: column;
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

.btn-ghost {
  color: #4A4A4A;
  border: 1px solid #4A4A4A;
  padding: 8px 24px;
  border-radius: 50px;
  font-weight: lighter;
  opacity: 0.6;
  transition: opacity 0.3s ease;
  margin: 5px 0 5px 0;
}

.btn-ghost:hover {
  opacity: 1;
  transform: scale(1.06);
}

.vhs-show-card {
  background: rgb(237, 236, 224);
  color: black;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
}
</style>
