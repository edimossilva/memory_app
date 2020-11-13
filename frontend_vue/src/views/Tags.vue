<template>
  <div>
    <list-tags class="m-4"> </list-tags>
    <section>
      <b-button
        data-cy="tags__add_tag_button"
        type="is-primary"
        @click="onAddButtonClick"
        icon-left="plus"
      >
        Add Tag
      </b-button>
      <b-modal
        v-model="isComponentModalActive"
        has-modal-card
        trap-focus
        :destroy-on-hide="true"
        aria-role="dialog"
        aria-modal
      >
        <template #default="props">
          <tag-modal
            titleLabel="Create tag"
            buttonLabel="Save"
            :errorMessage="tagModalErrorMessage"
            :onConfirmClick="onCreateModalConfirmButtonClick"
            @close="props.close"
          ></tag-modal>
        </template>
      </b-modal>
    </section>
  </div>
</template>

<script>
import ListTags from "@/components/tag/ListTags.vue";
import { createTagApi } from "../services/tagsApi";
import { mapActions } from "vuex";
import TagModal from "@/modals/TagModal.vue";

export default {
  name: "Tags",
  components: { ListTags, TagModal },
  data() {
    return {
      isComponentModalActive: false,
      tagModalErrorMessage: "",
    };
  },
  methods: {
    ...mapActions(["addTag"]),
    onAddButtonClick() {
      this.isComponentModalActive = true;
      this.tagModalErrorMessage = "";
    },
    onCreateModalConfirmButtonClick(tag) {
      createTagApi(tag).then(
        (response) => {
          this.addTag(response.data.data);
          this.isComponentModalActive = false;
        },
        (error) => {
          this.tag = {};
          this.tagModalErrorMessage = error.response.data.error_message;
        }
      );
    },
  },
};
</script>

<style></style>
