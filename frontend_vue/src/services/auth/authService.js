import router from "../../router/index";

export const logout = (query = {}) => {
  localStorage.token = "";
  router.push({ name: "Login", query: query });
};
