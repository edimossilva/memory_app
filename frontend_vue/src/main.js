import Vue from "vue";
import App from "./App.vue";
import Buefy from "buefy";
import router from "./router";
import store from "./store";
import VModal from "vue-js-modal";
import VueClipboard from "vue-clipboard2";
import "buefy/dist/buefy.css";

Vue.config.productionTip = false;
Vue.use(VModal);
Vue.use(Buefy);
Vue.use(VueClipboard);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
