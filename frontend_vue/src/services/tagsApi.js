import axios from "axios";
import { HOST, getRequestConfig } from "./api";

const TAGS_RESOURCE_URL = `${HOST}/tags`;

export const createTagApi = (tag) => {
  return axios.post(TAGS_RESOURCE_URL, tag, getRequestConfig());
};

export const editTagApi = (tag) => {
  const editUrl = `${TAGS_RESOURCE_URL}/${tag.id}`;
  return axios.put(editUrl, tag, getRequestConfig());
};

export const getTagsApi = () => {
  return axios.get(TAGS_RESOURCE_URL, getRequestConfig());
};

export const deleteTagApi = (tagId) => {
  const deleteUrl = `${TAGS_RESOURCE_URL}/${tagId}`;
  return axios.delete(deleteUrl, getRequestConfig());
};
