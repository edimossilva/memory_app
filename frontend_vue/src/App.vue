<template>
  <div id="app" class="has-background-white">
    <main-menu v-show="isLogged"></main-menu>
    <router-view />
  </div>
</template>
<script>
import MainMenu from "@/components/menus/MainMenu.vue";
import { mapState } from "vuex";

export default {
  name: "App",
  components: { MainMenu },
  computed: {
    ...mapState(["isLogged"]),
  },
};
</script>
<style>
html,
body {
  height: 100%;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100%;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
