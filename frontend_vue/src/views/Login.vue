<template>
  <div>
    <h1>Login</h1>
    <div>
      <label for="username">Username:</label>
      <input type="text" v-model="username" data-cy="username"/>
    </div>
    <div>
      <label for="password">Password:</label>
      <input type="password" v-model="password" autocomplete="new-password" data-cy="password"/>
    </div>
    <button @click="doLogin(username, password)" data-cy="loginButton">Login</button>
  </div>
</template>

<script>
import { doLoginApi } from "../services/api";
export default {
  data() {
    return {
      username: "registered_user1",
      password: "111"
    };
  },
  methods: {
    doLogin(username, password) {
      doLoginApi(username, password).then(
        result => {
          localStorage.token = result.data.token;
          this.$router.push({ name: "Home" });
        },
        error => {
          console.error(error.response.data.error_message);
        }
      );
    }
  }
};
</script>
