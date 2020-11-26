<template>
  <div data-cy="list_shareable_list">
    <div class="columns is-multiline">
      <div
        class="column is-one-third"
        v-for="shareableList in shareableLists"
        :key="shareableList.key"
      >
        <!-- <show-shareableList :shareableList="shareableList"></show-shareableList> -->
        {{ shareableList }}
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
// import ShowTag from "@/components/shareableList/ShowTag.vue";
import { getShareableListsApi } from "../../services/shareableListsApi";

export default {
  name: "ListTags",
  // components: { ShowTag },
  mounted() {
    getShareableListsApi().then(
      (response) => {
        this.setShareableLists(response.data.data);
      },
      (error) => {
        console.log(error);
      }
    );
  },
  data() {
    return {
      shareableList: { key: "", value: "" },
    };
  },
  computed: {
    ...mapState(["shareableLists"]),
  },
  methods: {
    ...mapActions(["setShareableLists"]),
  },
};
</script>
