import router from "../../router/index";
import store from "../../store/index";

export const logout = (query = {}) => {
  localStorage.token = "";

  store.dispatch("setIsLogged", false);

  router.push({ name: "Login", query: query });
};
