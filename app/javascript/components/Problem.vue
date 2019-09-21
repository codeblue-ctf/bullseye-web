<template>
  <div v-if="problem">
    <p>{{problem.title}}</p>

    <p>{{problem.description}}</p>

    <p>
      <strong>docker_compose.yml:</strong>
      <pre>{{problem.docker_compose}}</pre>
    </p>

    <div>
      <h2>Containers your team pushed</h2>

      <table>
        <thead>
          <tr>
            <th>image digest</th>
            <th>uploaded at</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="image in images">
            <th>{{image.image_digest}}</th>
            <th>{{image.uploaded_at}}</th>
          </tr>
        </tbody>
      </ul>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  props: ['id'],
  computed: {
    ...mapState('problem', {
      problem () {
        const detail = this.$store.state.problem.problemDetails.get(this.id)
        if (detail) {
          return detail.problem
        }
      },
      images () {
        const detail = this.$store.state.problem.problemDetails.get(this.id)
        if (detail) {
          return detail.images
        }
      }
    })
  },
  created () {
    this.$store.dispatch('problem/fetch', { id: this.id })
  }
}
</script>
