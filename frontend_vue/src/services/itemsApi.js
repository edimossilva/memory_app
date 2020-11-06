import axios from "axios";
import { HOST, getRequestConfig } from './api'

const ITEMS_RESOURCE_URL = `${HOST}/memories`;

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
