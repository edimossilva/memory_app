import axios from "axios";
import { HOST, getRequestConfig, deleteApi, editApi } from "./api";

const SHAREABLE_LIST_RESOURCE_URL = `${HOST}/api/v1/shareable_lists`;

export const createShareableListApi = (tag) => {
  return axios.post(SHAREABLE_LIST_RESOURCE_URL, tag, getRequestConfig());
};

export const editShareableListApi = (tag) => {
  return editApi(`${SHAREABLE_LIST_RESOURCE_URL}/${tag.id}`, tag);
};

export const getShareableListsApi = () => {
  return axios.get(SHAREABLE_LIST_RESOURCE_URL, getRequestConfig());
};

export const deleteShareableListApi = (tagId) => {
  return deleteApi(`${SHAREABLE_LIST_RESOURCE_URL}/${tagId}`);
};
