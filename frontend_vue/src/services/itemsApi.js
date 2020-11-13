import axios from "axios";
import { HOST, getRequestConfig, deleteApi, editApi } from "./api";

const ITEMS_RESOURCE_URL = `${HOST}/memories`;

export const createItemApi = (item) => {
  return axios.post(ITEMS_RESOURCE_URL, item, getRequestConfig());
};

export const editItemApi = (item) => {
  return editApi(`${ITEMS_RESOURCE_URL}/${item.id}`, item);
};

export const getItemsApi = () => {
  return axios.get(ITEMS_RESOURCE_URL, getRequestConfig());
};

export const deleteItemApi = (itemId) => {
  return deleteApi(`${ITEMS_RESOURCE_URL}/${itemId}`);
};
