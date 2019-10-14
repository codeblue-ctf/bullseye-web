<template>
  <nav>
    <router-link to="/">Home</router-link>
    <router-link to="/problems">Problems</router-link>
    <template v-if="!signedIn">
      <router-link to="/signin">Sign In</router-link>
    </template>
    <template v-else>
      <span v-if="currentTeam">Team: {{ currentTeam.name }}</span>
      <router-link to="/logout">Logout</router-link>
    </template>
  </nav>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
    ...mapState('auth', ['signedIn', 'currentTeam'])
  }
}
</script>
