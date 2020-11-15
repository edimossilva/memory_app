import axios from "axios";
import { HOST, getRequestConfig, deleteApi, editApi } from "./api";

const ITEMS_RESOURCE_URL = `${HOST}/api/v1/memories`;

export const createItemApi = (item) => {
  const { key, value } = item;
  const tags_ids = item.tags.map((tag) => tag.id);
  const itemJson = {
    key,
    value,
    tags_ids: tags_ids,
  };
  return axios.post(ITEMS_RESOURCE_URL, itemJson, getRequestConfig());
};

export const editItemApi = (item) => {
  const { key, value } = item;
  const tags_ids = item.tags.map((tag) => tag.id);
  const itemJson = {
    key,
    value,
    tags_ids: tags_ids,
  };
  return editApi(`${ITEMS_RESOURCE_URL}/${item.id}`, itemJson);
};

export const getItemsApi = () => {
  return axios.get(ITEMS_RESOURCE_URL, getRequestConfig());
};

export const deleteItemApi = (itemId) => {
  return deleteApi(`${ITEMS_RESOURCE_URL}/${itemId}`);
};
