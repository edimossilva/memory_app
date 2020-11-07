<template>
  <b-navbar>
    <template slot="end">
      <b-navbar-item tag="div">
        <b-navbar-item
          data-cy="main_menu__logout"
          @click="onLogoutButtonClick()"
          class="button is-light"
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
