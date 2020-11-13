<template>
  <div class="home">
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
import { createItemApi } from "../services/itemsApi";
import { mapActions } from "vuex";

export default {
  name: "Home",
  components: { ListItems, ItemModal },
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
