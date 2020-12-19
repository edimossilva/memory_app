<template>
  <div>
    <list-shareable-list class="m-4"> </list-shareable-list>
    <b-button
      data-cy="shareable_lists__add_shareable_list_button"
      type="is-primary"
      @click="onAddButtonClick"
      icon-left="plus"
    >
      Add Shareable List
    </b-button>
  </div>
</template>

<script>
import ListShareableList from "@/components/shareable_list/ListShareableList.vue";

export default {
  name: "ShareableLists",
  components: { ListShareableList },
  data() {
    return {};
  },
  methods: {
    onAddButtonClick() {
      this.$router.push({ name: "NewShareableList" });
    },
  },
};
</script>

<style></style>
