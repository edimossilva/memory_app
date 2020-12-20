<template>
  <div>
    <list-items
      :copy-only="true"
      :external-items="shareableList.items"
      class="m-4"
    >
      <div class="notification is-secondary mb-5 p-2">
        <h1 class="is-size-3">{{ this.shareableList.name }}</h1>
      </div>

      <div class="notification is-secondary mb-6 p-2">
        <a class="is-size-5" :href="this.shareableListUrl">{{
          this.shareableListUrl
        }}</a>
      </div>
    </list-items>
  </div>
</template>

<script>
import ListItems from "@/components/item/ListItems.vue";
import {
  getShareableListApi,
  getPublicShareableListApi,
} from "../../services/shareableListsApi";

export default {
  name: "DisplayShareableItem",
  components: { ListItems },
  mounted() {
    this.id = this.$route.params.id;
    if (this.id) {
      getShareableListApi(this.id).then(this.setShareableList, (error) => {
        console.log(error);
      });
    } else {
      const username = this.$route.params.username;
      const shareableListName = this.$route.params.shareableListName;
      getPublicShareableListApi(username, shareableListName).then(
        this.setShareableList,
        (error) => {
          console.log(error);
        }
      );
    }
  },
  data() {
    return {
      shareableList: { name: "", items: [] },
      id: null,
      isPublic: false,
    };
  },
  computed: {
    shareableListUrl() {
      if (this.isPublic) {
        return window.location.href;
      }
      const username = localStorage.username;
      const shareableListName = this.shareableList.name;
      const host = window.location.href.split("shareable_list")[0];
      return `${host}${username}/${shareableListName}`;
    },
  },
  methods: {
    setShareableList(response) {
      this.isPublic = true;
      this.shareableList = response.data.data;
      this.shareableList.items = this.shareableList.memories;
      delete this.shareableList.memories;
    },
  },
};
</script>
<style></style>
