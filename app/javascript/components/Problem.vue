<template>
  <div>
    <p>{{problem.title}}</p>

    <p>{{problem.description}}</p>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
    ...mapState('problem', {
      problem (state) {
        return state.problems.find(p => p.id === this.$route.params.id)
      }
    })
  }
}
</script>
