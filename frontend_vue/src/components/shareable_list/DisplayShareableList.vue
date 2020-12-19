<template>
  <div>
    <list-items
      :copy-only="true"
      :external-items="shareableList.items"
      class="m-4"
    >
      <div class="notification is-secondary mb-6 p-2">
        <h1 class="is-size-3">{{ this.shareableList.name }}</h1>
      </div>
    </list-items>
  </div>
</template>

<script>
import ListItems from "@/components/item/ListItems.vue";
import { getShareableListApi } from "../../services/shareableListsApi";

export default {
  name: "DisplayShareableItem",
  components: { ListItems },
  mounted() {
    this.id = this.$route.params.id;
    if (this.id) {
      getShareableListApi(this.id).then(
        (response) => {
          this.shareableList = response.data.data;
          this.shareableList.items = this.shareableList.memories;
          delete this.shareableList.memories;
        },
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
    };
  },
};
</script>
<style></style>
