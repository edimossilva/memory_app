<template>
  <div class="home">
    <main-menu></main-menu>
    <list-items class="m-4"></list-items>
    <section>
      <b-button
        data-cy="home__add_item_button"
        type="is-primary"
        @click="onAddButtonClick"
        icon-left="plus"
      >
        Add
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
          <item-modal
            titleLabel="Create Item"
            buttonLabel="Save"
            :errorMessage="itemModalErrorMessage"
            :onConfirmClick="onCreateModalConfirmButtonClick"
            @close="props.close"
          ></item-modal>
        </template>
      </b-modal>
    </section>
  </div>
</template>

<script>
import ListItems from "@/components/item/ListItems.vue";
import ItemModal from "@/modals/ItemModal.vue";
import MainMenu from "@/components/menus/MainMenu.vue";
import { createItemApi } from "../services/itemsApi";
import { mapActions } from "vuex";

export default {
  name: "Home",
  components: { ListItems, ItemModal, MainMenu },
  data() {
    return {
      isComponentModalActive: false,
      itemModalErrorMessage: "",
    };
  },
  methods: {
    ...mapActions(["addItem"]),
    onAddButtonClick() {
      this.isComponentModalActive = true;
      this.itemModalErrorMessage = "";
    },
    onCreateModalConfirmButtonClick(item) {
      createItemApi(item).then(
        (response) => {
          this.addItem(response.data.data);
          this.isComponentModalActive = false;
        },
        (error) => {
          this.item = {};
          this.itemModalErrorMessage = error.response.data.error_message;
        }
      );
    },
  },
};
</script>
