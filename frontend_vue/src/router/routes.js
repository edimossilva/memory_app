import Home from "../views/Home.vue";
import Login from "../views/Login.vue";
import Tags from "../views/Tags.vue";
import ShareableLists from "../views/ShareableLists.vue";
import NewShareableList from "../views/NewShareableList.vue";
import OmniauthCallback from "../components/auth/OmniauthCallback.vue";
import { checkAuthApi } from "../services/authApi";
import { logout } from "../services/auth/authService";

const checkToken = function (to, from, next) {
  checkAuthApi()
    .then(() => {
      next();
    })
    .catch((error) => {
      console.log(error.response.data);
      localStorage.token = "";
      logout({ tokenExpired: true });
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
    path: "/tags",
    name: "Tags",
    component: Tags,
    meta: {
      requiresAuth: true,
    },
    beforeEnter: (to, from, next) => {
      checkToken(to, from, next);
    },
  },
  {
    path: "/shareable_lists",
    name: "ShareableLists",
    component: ShareableLists,
    meta: {
      requiresAuth: true,
    },
    beforeEnter: (to, from, next) => {
      checkToken(to, from, next);
    },
  },
  {
    path: "/shareable_list/new",
    name: "NewShareableList",
    component: NewShareableList,
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
