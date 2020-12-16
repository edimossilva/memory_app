import axios from "axios";
import { HOST, getRequestConfig, deleteApi, editApi } from "./api";

const SHAREABLE_LIST_RESOURCE_URL = `${HOST}/api/v1/shareable_lists`;

export const createShareableListApi = (shareableList) => {
  const itemsIds = shareableList.items.map((item) => item.id);
  const shareableListJson = {
    name: shareableList.name,
    memories_ids: itemsIds,
  };
  return axios.post(
    SHAREABLE_LIST_RESOURCE_URL,
    shareableListJson,
    getRequestConfig()
  );
};

export const editShareableListApi = (shareableList) => {
  return editApi(
    `${SHAREABLE_LIST_RESOURCE_URL}/${shareableList.id}`,
    shareableList
  );
};
export const getShareableListApi = (shareableListId) => {
  return axios.get(
    `${SHAREABLE_LIST_RESOURCE_URL}/${shareableListId}`,
    getRequestConfig()
  );
};
export const getShareableListsApi = () => {
  return axios.get(SHAREABLE_LIST_RESOURCE_URL, getRequestConfig());
};

export const deleteShareableListApi = (shareableListId) => {
  return deleteApi(`${SHAREABLE_LIST_RESOURCE_URL}/${shareableListId}`);
};
