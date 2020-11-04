import axios from "axios";

const HOST =
  process.env.VUE_APP_API_URL || "https://memory-app-back.herokuapp.com";

const LOGIN_URL = `${HOST}/auth/login`;
export const OMNIAUTH_URL = `${HOST}/auth/sign_up`;

export const doLoginApi = (username, password) => {
  const params = { username, password };

  return axios.post(LOGIN_URL, params);
};
