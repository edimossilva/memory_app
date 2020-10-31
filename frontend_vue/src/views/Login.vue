<template>
  <div class="container">
    <div class="notification is-light">
      <div>
        <b-field
          label="Username"
          label-position="inside"
          type="is-primary"
          class="mx-4 mb-4"
        >
          <b-input type="text" v-model="username" data-cy="username"> </b-input>
        </b-field>
      </div>

      <div>
        <b-field
          label="Password"
          label-position="inside"
          type="is-primary"
          class="mx-4"
        >
          <b-input
            @keyup.enter.native="doLogin"
            type="password"
            v-model="password"
            autocomplete="new-password"
            data-cy="password"
          ></b-input>
        </b-field>
      </div>
      <b-button
        class="m-4"
        @click="doLogin()"
        type="is-primary"
        data-cy="loginButton"
        outlined
        >Login</b-button
      >
    </div>
  </div>
</template>

<script>
import { doLoginApi } from '../services/api';
export default {
  data() {
    return {
      username: 'registered_user1',
      password: '111',
    };
  },
  methods: {
    doLogin() {
      const { username, password } = this;
      doLoginApi(username, password).then(
        (result) => {
          localStorage.token = result.data.token;
          this.$router.push({ name: 'Home' });
        },
        (error) => {
          this.showError();
          console.error(error.response.data.error_message);
        }
      );
    },
    showError() {
      this.$buefy.dialog.alert({
        message: 'Invalid Login or password.',
        type: 'is-danger',
        ariaRole: 'alertdialog',
        ariaModal: true,
      });
    },
  },
};
</script>
