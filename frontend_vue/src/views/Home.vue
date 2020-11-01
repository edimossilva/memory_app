<template>
  <div class="home">
    <list-items class="m-4"></list-items>
    <section>
      <b-button type="is-primary" @click="isComponentModalActive = true"
        >Add</b-button
      >
      <b-modal
        v-model="isComponentModalActive"
        has-modal-card
        trap-focus
        :destroy-on-hide="false"
        aria-role="dialog"
        aria-modal
      >
        <template #default="props">
          <add-item-modal @close="props.close"></add-item-modal>
        </template>
      </b-modal>
    </section>
  </div>
</template>

<script>
import ListItems from "@/components/item/ListItems.vue";
import AddItemModal from "@/modals/AddItemModal.vue";

export default {
  name: "Home",
  components: { ListItems, AddItemModal },
  data() {
    return {
      isComponentModalActive: false,
    };
  },
};
</script>
