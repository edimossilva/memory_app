import axios from "axios";
import { HOST, getRequestConfig, deleteApi, editApi } from "./api";

const TAGS_RESOURCE_URL = `${HOST}/api/v1/tags`;

export const createTagApi = (tag) => {
  return axios.post(TAGS_RESOURCE_URL, tag, getRequestConfig());
};

export const editTagApi = (tag) => {
  return editApi(`${TAGS_RESOURCE_URL}/${tag.id}`, tag);
};

export const getTagsApi = () => {
  return axios.get(TAGS_RESOURCE_URL, getRequestConfig());
};

export const deleteTagApi = (tagId) => {
  return deleteApi(`${TAGS_RESOURCE_URL}/${tagId}`);
};
