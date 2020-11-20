<template>
  <b-navbar class="has-background-white" :transparent="true">
    <template slot="brand">
      <b-navbar-item>
        <a
          href="https://github.com/edimossilva/memory_app"
          data-cy="main-menu__navbar-item-github"
        >
          <img
            src="https://icons-for-free.com/iconfiles/png/512/part+1+github-1320568339880199515.png"
            alt="Lightweight UI components for Vue.js based on Bulma"
          />
        </a>
      </b-navbar-item>
    </template>
    <template slot="start">
      <b-navbar-item href="/" data-cy="main-menu__navbar-item-items">
        Items
      </b-navbar-item>
      <b-navbar-item href="/tags" data-cy="main-menu__navbar-item-tags">
        Tags
      </b-navbar-item>
    </template>
    <template slot="end">
      <b-navbar-item tag="div">
        <b-navbar-item
          data-cy="main_menu__logout"
          @click="onLogoutButtonClick()"
          class="button is-white"
        >
          Logout
        </b-navbar-item>
      </b-navbar-item>
    </template>
  </b-navbar>
</template>

<script>
import { logout } from "@/services/auth/authService";
export default {
  name: "MainMenu",
  mounted() {},
  methods: {
    onLogoutButtonClick() {
      logout();
    },
  },
};
</script>

<style></style>
