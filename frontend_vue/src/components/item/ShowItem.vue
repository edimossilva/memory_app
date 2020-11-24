<template>
  <div class="h-100">
    <div
      class="card bm--card-equal-height"
      :data-cy="`show_item__card_${item.key}`"
    >
      <header class="card-header">
        <p class="card-header-title is-centered">
          <text-highlight :queries="queries"> {{ item.key }}</text-highlight>
        </p>
      </header>
      <div class="card-content h-100">
        <div class="content h-100 has-text-black">
          <a
            v-if="isUrl"
            :href="item.value"
            :data-cy="`show_item__a_${item.key}`"
            target="_blank"
          >
            <text-highlight :queries="queries">
              {{ item.value }}
            </text-highlight>
          </a>
          <text-highlight v-else :queries="queries">
            {{ item.value }}</text-highlight
          >
        </div>
        <div class="tags is-centered">
          <span
            v-for="tag in item.tags"
            :key="tag.id"
            class="tag is-light"
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
import {
  successNotify,
  infoNotify,
  dangerNotify,
} from "../../services/notifications/notificationsService";
import ItemModal from "@/modals/ItemModal.vue";

export default {
  name: "ShowItem",
  props: {
    item: { type: Object, required: true },
    queries: { type: Array, required: true },
  },
  components: { ItemModal },
  data() {
    return {
      isComponentModalActive: false,
      itemModalErrorMessage: "",
    };
  },
  computed: {
    isUrl() {
      const { item } = this;
      if (item.value.includes("http://") || item.value.includes("https://")) {
        return true;
      }
      return false;
    },
  },
  methods: {
    ...mapActions(["removeItem", "editItem"]),
    onRemoveButtonClick() {
      this.$buefy.dialog.confirm({
        message: `Are you sure you want to <b>DELETE</b> "${this.item.key}"?`,
        confirmText: "Delete",
        type: "is-danger",
        onConfirm: () => this.deleteItem(),
      });
    },
    deleteItem() {
      const { item, removeItem, $buefy } = this;
      deleteItemApi(item.id).then(
        () => {
          removeItem(item);
          dangerNotify($buefy, `"${item.key}" deleted`);
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
        infoNotify($buefy, `"${item.value}" copied to clipboard :)`);
      });
    },
    onEditButtonClick() {
      this.isComponentModalActive = true;
      this.itemModalErrorMessage = "";
    },
    onEditModalConfirmButtonClick(item) {
      const { editItem, $buefy } = this;

      editItemApi(item).then(
        (response) => {
          editItem(response.data.data);
          this.isComponentModalActive = false;
          successNotify($buefy, `"${item.value}" saved :)`);
        },
        (error) => {
          this.itemModalErrorMessage = error.response.data.error_message;
        }
      );
    },
  },
};
</script>
<style lang="css" scoped>
.h-100 {
  height: 100%;
}
.bm--card-equal-height {
  display: flex;
  flex-direction: column;
  height: 100%;
}
.bm--card-equal-height .card-footer {
  margin-top: auto;
}
.card-content {
  display: flex;
  flex-direction: column;
}
.content {
  width: 100%;
}
</style>
