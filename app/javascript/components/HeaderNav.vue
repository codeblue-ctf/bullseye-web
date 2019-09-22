<template>
  <nav>
    <ul>
      <router-link to="/">Home</router-link>
      <router-link to="/problems">Problems</router-link>
      <template v-if="!signedIn">
        <router-link to="/signin">Sign In</router-link>
      </template>
      <template v-else>
        <router-link to="/logout">Logout</router-link>
      </template>
    </ul>
  </nav>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
    ...mapState('auth', ['signedIn'])
  }
}
</script>
