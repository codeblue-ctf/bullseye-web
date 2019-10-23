<template>
  <div>
    <h1 class="display-4 mb-4">Problems</h1>

    <div class="row">
      <div class="col-sm-2" v-for="problem in problems">
        <div class="card">
          <router-link class="card-body" :to="{ name: 'problem', params: { id: problem.id } }">{{ problem.title }}</router-link>
        </div>
      </div>
    </div>
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
