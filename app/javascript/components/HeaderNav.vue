<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
      <span class="navbar-brand">CODE BLUE CTF</span>
      <ul class="navbar-nav mr-auto">
        <li class="nav-item"><router-link to="/" class="nav-link">Home</router-link></li>
        <li class="nav-item"><router-link to="/problems" class="nav-link">Problems</router-link></li>
      </ul>
      <ul class="navbar-nav my-2 my-lg-0">
        <template v-if="!signedIn">
          <li class="nav-item"><router-link to="/signin" class="nav-link">Sign In</router-link></li>
        </template>
        <template v-else>
          <li class="nav-item"><span v-if="currentTeam" class="navbar-text">Team: {{ currentTeam.name }}</span><li>
          <li class="nav-item"><router-link to="/logout" class="nav-link">Logout</router-link></li>
        </template>
      </ul>
    </div>
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
