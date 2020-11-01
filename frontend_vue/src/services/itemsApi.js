import axios from "axios";

const HOST =
  process.env.VUE_APP_API_URL || "https://memory-app-back.herokuapp.com";

const ITEMS_RESOURCE_URL = `${HOST}/memories`;

export const getRequestConfig = () => {
  const token = localStorage.getItem("token");
  const requestConfig = {
    headers: {
      Authorization: `Basic ${token}`,
    },
  };

  return requestConfig;
};

export const createItemApi = (item) => {
  return axios.post(ITEMS_RESOURCE_URL, item, getRequestConfig());
};

export const getItemsApi = () => {
  return axios.get(ITEMS_RESOURCE_URL, getRequestConfig());
};

export const deleteItemApi = (itemId) => {
  const deleteUrl = `${ITEMS_RESOURCE_URL}/${itemId}`;
  return axios.delete(deleteUrl, getRequestConfig());
};
