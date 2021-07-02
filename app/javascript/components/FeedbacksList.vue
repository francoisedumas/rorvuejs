<template>
  <div class="container">
    <div>
      <button class="btn vhs-button" @click="newFeedbackVisible = !newFeedbackVisible">
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
    <ul class="border-test">
      <li class="vhs-show-card" v-for="feedback in feedbacks" :key="feedback.id" :feedback="feedback">
        <img src="https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/skateboard.jpg" />
        <div>
          <h2>{{ feedback.title }}</h2>
          <p>{{ feedback.description }}</p>
        </div>
        <Rating
          :grade="feedback.rating"
          :maxStars="5"
          :hasCounter="true"
          @update-star="updateStar(feedback.id, $event)"
          :key="componentKey"
        />
        <button class="vhs-validation" @click="deleteFeedback(feedback.id)">
          {{ "Delete" }}
        </button>
      </li>
    </ul>
  </div>
</template>

<script>
import { api } from '../packs/api/client';
import Rating from './Rating.vue'

export default {
  data() {
    return {
      feedbacks: [],
      newFeedbackVisible: false,
      newDescription: "",
      newTitle: "",
      componentKey: 0,
    }
  },
  components: {
    Rating
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
    },
    deleteFeedback(id) {
      return api.destroyFeedback(id).then((_response) => {
        let index = this.feedbacks.findIndex( f => f.id === id );
        this.$delete(this.feedbacks, index)
      });
    },
    updateStar(id, star) {
      return api.updateFeedbacks(id, star).then((response) => {
        const feedback = this.feedbacks.find( f => f.id === id );
        feedback.rating = response.data.rating;
        this.componentKey += 1;
      });
    },
  },
}
</script>
