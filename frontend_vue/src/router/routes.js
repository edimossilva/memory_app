import Home from "../views/Home.vue";
import Login from "../views/Login.vue";
import OmniauthCallback from "../components/auth/OmniauthCallback.vue";
import { checkAuthApi } from "../services/api";

const checkToken = function (to, from, next) {
  checkAuthApi()
    .then(() => {
      next();
    })
    .catch((error) => {
      console.log(error.response.data);
      localStorage.token = "";
      next({ name: "Login", query: { tokenExpired: true } });
    });
};

export const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
    meta: {
      requiresAuth: true,
    },
    beforeEnter: (to, from, next) => {
      checkToken(to, from, next);
    },
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
    meta: {
      requiresAuth: false,
    },
  },
  {
    path: "/omniauth_callback",
    name: "OmniauthCallback",
    component: OmniauthCallback,
    meta: {
      requiresAuth: false,
    },
  },
  {
    path: "/about",
    name: "About",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/About.vue"),
    meta: {
      requiresAuth: true,
    },
    beforeEnter: (to, from, next) => {
      checkToken(to, from, next);
    },
  },
];
