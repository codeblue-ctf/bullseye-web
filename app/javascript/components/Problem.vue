<template>
  <div v-if="detail">
    <p>{{detail.problem.title}}</p>

    <p>{{detail.problem.description}}</p>

    <div>
      <strong>docker_compose.yml:</strong>
      <pre>{{detail.problem.docker_compose}}</pre>
    </div>

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
          <tr v-for="image in detail.images">
            <td>{{image.image_digest}}</td>
            <td>{{image.uploaded_at}}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  props: ['id'],
  computed: {
    ...mapState('problem', {
      detail(state) {
        return state.problemDetails[this.id]
      }
    })
  },
  created () {
    this.$store.dispatch('problem/fetch', { id: this.id })
  }
}
</script>
