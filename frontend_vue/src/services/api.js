import axios from "axios";

export const HOST =
  process.env.VUE_APP_API_URL || "https://memory-app-back.herokuapp.com";

export const getRequestConfig = () => {
  const token = localStorage.getItem("token");
  const requestConfig = {
    headers: {
      Authorization: `Basic ${token}`,
    },
  };

  return requestConfig;
};

export const deleteApi = (url) => {
  return axios.delete(url, getRequestConfig());
};

export const editApi = (url, resource) => {
  return axios.put(url, resource, getRequestConfig());
};
