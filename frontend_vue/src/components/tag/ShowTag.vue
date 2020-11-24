<template>
  <div>
    <div class="card" :data-cy="`show_tag__card_${tag.name}`">
      <div class="card-content">
        <div class="content">
          <span class="tag is-medium is-light"> {{ tag.name }}</span>
        </div>
      </div>
      <footer class="card-footer">
        <a
          class="card-footer-item"
          :data-cy="`show_tag__edit_button_${tag.name}`"
          @click.prevent="onEditButtonClick"
        >
          <b-icon icon="edit" size="is-small"> </b-icon>
        </a>
        <a
          class="card-footer-item has-text-danger"
          :data-cy="`show_tag__delete_button_${tag.name}`"
          @click.prevent="onRemoveButtonClick"
        >
          <b-icon icon="trash-alt" size="is-small"> </b-icon>
        </a>
      </footer>
    </div>

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
          titleLabel="Edit Tag"
          buttonLabel="Save"
          :errorMessage="tagModalErrorMessage"
          :initialTag="tag"
          :onConfirmClick="onEditModalConfirmButtonClick"
          @close="props.close"
        >
        </tag-modal>
      </template>
    </b-modal>
  </div>
</template>

<script>
import { mapActions } from "vuex";
import { deleteTagApi, editTagApi } from "../../services/tagsApi";
import TagModal from "@/modals/TagModal.vue";
import {
  successNotify,
  dangerNotify,
} from "../../services/notifications/notificationsService";
export default {
  name: "ShowTag",
  props: {
    tag: { type: Object, required: true },
  },
  components: { TagModal },
  data() {
    return {
      isComponentModalActive: false,
      tagModalErrorMessage: "",
    };
  },
  methods: {
    ...mapActions(["removeTag", "editTag"]),
    onRemoveButtonClick() {
      this.$buefy.dialog.confirm({
        message: `Are you sure you want to <b>DELETE</b> "${this.tag.name}"?`,
        confirmText: "Delete",
        type: "is-danger",
        onConfirm: () => this.deleteItem(),
      });
    },
    deleteItem() {
      deleteTagApi(this.tag.id).then(
        () => {
          this.removeTag(this.tag);
          dangerNotify(this.$buefy, `"${this.tag.name}" deleted`);
        },
        (error) => {
          // this.showError();
          console.log(error.response.data.error_message);
        }
      );
    },
    onEditButtonClick() {
      this.isComponentModalActive = true;
      this.tagModalErrorMessage = "";
    },
    onEditModalConfirmButtonClick(tag) {
      editTagApi(tag).then(
        (response) => {
          this.editTag(response.data.data);
          this.isComponentModalActive = false;
          successNotify(this.$buefy, `"${tag.name}" saved :)`);
        },
        (error) => {
          this.tagModalErrorMessage = error.response.data.error_message;
        }
      );
    },
  },
};
</script>
