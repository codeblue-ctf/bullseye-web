<template>
  <div>
    <p>problems</p>

    <ul>
      <li v-for="problem in problems">
        <router-link :to="{ name: 'problem', params: { id: problem.id } }">{{ problem.title }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
    ...mapState('problem', ['problems'])
  },
  created () {
    this.$store.dispatch('problem/fetchAll')
  }
}
</script>
