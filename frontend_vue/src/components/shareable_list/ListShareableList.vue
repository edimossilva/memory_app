<template>
  <div data-cy="list_shareable_list">
    <div class="columns is-multiline">
      <div
        class="column"
        v-for="shareableList in shareableLists"
        :key="shareableList.key"
      >
        <show-shareable-list
          :shareableList="shareableList"
        ></show-shareable-list>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import ShowShareableList from "@/components/shareable_list/ShowShareableList";
import { getShareableListsApi } from "../../services/shareableListsApi";

export default {
  name: "ListTags",
  components: { ShowShareableList },
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
