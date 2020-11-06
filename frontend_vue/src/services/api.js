import axios from "axios";

const HOST =
  process.env.VUE_APP_API_URL || "https://memory-app-back.herokuapp.com";

const LOGIN_URL = `${HOST}/auth/login`;
const CHECK_TOKEN_URL = `${HOST}/auth/check`;
export const OMNIAUTH_URL = `${HOST}/auth/sign_up`;

export const getRequestConfig = () => {
  const token = localStorage.getItem("token");
  const requestConfig = {
    headers: {
      Authorization: `Basic ${token}`,
    },
  };

  return requestConfig;
};

export const doLoginApi = (username, password) => {
  const params = { username, password };

  return axios.post(LOGIN_URL, params);
};

export const checkAuthApi = () => {
  return axios.get(CHECK_TOKEN_URL, getRequestConfig());
};
