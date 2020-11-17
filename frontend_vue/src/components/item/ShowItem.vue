<template>
  <div>
    <div class="card" :data-cy="`show_item__card_${item.key}`">
      <div class="card-content">
        <div class="content">{{ item.key }}: {{ item.value }}</div>
        <div class="tags is-centered">
          <span
            v-for="tag in item.tags"
            :key="tag.id"
            class="tag is-info"
            :data-cy="`show_item__tag_${tag.name}`"
          >
            {{ tag.name }}
          </span>
        </div>
      </div>
      <footer class="card-footer">
        <a
          class="card-footer-item"
          :dataId="item.key"
          @click.prevent="onCopyButtonClick"
        >
          <b-icon icon="copy" size="is-small"> </b-icon>
        </a>

        <a
          class="card-footer-item"
          :data-cy="`show_item__edit_button_${item.key}`"
          @click.prevent="onEditButtonClick"
        >
          <b-icon icon="edit" size="is-small"> </b-icon>
        </a>
        <a
          class="card-footer-item has-text-danger"
          :data-cy="`show_item__delete_button_${item.key}`"
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
        <item-modal
          titleLabel="Edit Item"
          buttonLabel="Save"
          :errorMessage="itemModalErrorMessage"
          :initialItem="item"
          :onConfirmClick="onEditModalConfirmButtonClick"
          @close="props.close"
        >
        </item-modal>
      </template>
    </b-modal>
  </div>
</template>

<script>
import { mapActions } from "vuex";
import { deleteItemApi, editItemApi } from "../../services/itemsApi";
import ItemModal from "@/modals/ItemModal.vue";

export default {
  name: "ShowItem",
  props: {
    item: { type: Object, required: true },
  },
  components: { ItemModal },
  data() {
    return {
      isComponentModalActive: false,
      itemModalErrorMessage: "",
    };
  },
  methods: {
    ...mapActions(["removeItem", "editItem"]),
    onRemoveButtonClick() {
      deleteItemApi(this.item.id).then(
        () => {
          this.removeItem(this.item);
        },
        (error) => {
          // this.showError();
          console.log(error.response.data.error_message);
        }
      );
    },
    onCopyButtonClick() {
      const { item, $copyText, $buefy } = this;
      $copyText(item.value).then(() => {
        $buefy.dialog.alert({
          message: `"${item.value}" copied to clipboard :)`,
          type: "is-primary",
          ariaRole: "alertdialog",
          ariaModal: true,
        });
      });
    },
    onEditButtonClick() {
      this.isComponentModalActive = true;
      this.itemModalErrorMessage = "";
    },
    onEditModalConfirmButtonClick(item) {
      editItemApi(item).then(
        (response) => {
          this.editItem(response.data.data);
          this.isComponentModalActive = false;
        },
        (error) => {
          this.itemModalErrorMessage = error.response.data.error_message;
        }
      );
    },
  },
};
</script>
