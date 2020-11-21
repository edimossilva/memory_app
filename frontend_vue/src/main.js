import Vue from "vue";
import App from "./App.vue";
import Buefy from "buefy";
import router from "./router";
import store from "./store";
import VModal from "vue-js-modal";
import VueClipboard from "vue-clipboard2";
import TextHighlight from "vue-text-highlight";

import "buefy/dist/buefy.css";
import "./assets/scss/variables.scss";

import { library } from "@fortawesome/fontawesome-svg-core";
import {
  faCopy,
  faEdit,
  faTrashAlt,
  faSignOutAlt,
  faPlus,
  faSave,
  faSearch,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

library.add(faCopy, faEdit, faTrashAlt, faSignOutAlt, faPlus, faSave, faSearch);
Vue.component("text-highlight", TextHighlight);
Vue.component("vue-fontawesome", FontAwesomeIcon);
Vue.config.productionTip = false;
Vue.use(VModal);
Vue.use(VueClipboard);
Vue.use(Buefy, {
  defaultIconComponent: "vue-fontawesome",
  defaultIconPack: "fas",
});
new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
