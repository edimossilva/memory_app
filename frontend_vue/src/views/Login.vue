<template>
  <div class="columns is-mobile is-centered is-vcentered login">
    <div class="container column is-half-desktop">
      <div class="box has-background-secondary">
        <div>
          <div class="login__image-container mb-4">
            <b-image
              class="login__image"
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_h4yKLD7Nx0MvkuVDshGADdvB-KjNR4O6ng&usqp=CAU"
              alt="A random image"
              :rounded="true"
            ></b-image>
          </div>

          <b-field
            label="Username"
            label-position="inside"
            type="is-primary"
            class="mx-4 mb-4"
          >
            <b-input
              type="text"
              v-model="username"
              data-cy="username"
              icon="user"
            >
            </b-input>
          </b-field>
        </div>

        <div v-on:keyup.enter="doLogin">
          <b-field
            label="Password"
            label-position="inside"
            type="is-primary"
            class="mx-4"
          >
            <b-input
              type="password"
              v-model="password"
              autocomplete="new-password"
              data-cy="password"
              icon="key"
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
        <a class="m-4 button is-danger is-outlined" :href="omniauthUrl"
          >Login Gmail</a
        >
      </div>
    </div>
  </div>
</template>

<script>
import { doLoginApi, OMNIAUTH_URL } from "../services/authApi";
export default {
  data() {
    return {
      username: "registered_user1",
      password: "111",
    };
  },
  mounted() {
    const tokenExpired = this.$route.query.tokenExpired;
    if (tokenExpired) {
      this.showTokenExpired();
    }
  },
  computed: {
    omniauthUrl() {
      return OMNIAUTH_URL;
    },
  },
  methods: {
    doLogin() {
      const { username, password } = this;
      doLoginApi(username, password).then(
        (result) => {
          localStorage.token = result.data.token;
          this.$router.push({ name: "Home" });
        },
        (error) => {
          this.showError();
          console.error(error.response.data.error_message);
        }
      );
    },
    showError() {
      this.$buefy.dialog.alert({
        message: "Invalid Login or password.",
        type: "is-danger",
        ariaRole: "alertdialog",
        ariaModal: true,
      });
    },
    showTokenExpired() {
      this.$buefy.dialog.alert({
        message: "Token Expired :(",
        type: "is-danger",
        ariaRole: "alertdialog",
        ariaModal: true,
      });
    },
  },
};
</script>
<style scoped>
.login {
  height: 100%;
}
.login__image {
  height: 100px;
  width: 100px;
}
.login__image-container {
  display: flex;
  justify-content: center;
}
</style>
