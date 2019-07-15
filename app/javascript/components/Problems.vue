<template>
  <div>
    <p>problems</p>

    <ul>
      <li v-for="problem in problems">
        {{ problem.title }}
      </li>
    </ul>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  mounted () {
    console.log(this)
    this.$store.dispatch('problem/fetch')
  },
  computed: {
    ...mapState('problem', ['problems'])
  }
}
</script>
