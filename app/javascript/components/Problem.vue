<template>
  <div v-if="problem">
    <p>{{problem.title}}</p>

    <p>{{problem.description}}</p>

    <p>
      <strong>docker_compose.yml:</strong>
      <pre>{{problem.docker_compose}}</pre>
    </p>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  props: ['id'],
  computed: {
    ...mapState('problem', {
      problem () {
        return this.$store.state.problem.problems.find(p => p.id === this.id)
      }
    })
  },
  created () {
    this.$store.dispatch('problem/fetch')
  }
}
</script>
