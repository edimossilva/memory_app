<template>
  <div class="home">
    <create-item-modal></create-item-modal>
    <list-items class="m-4"></list-items>
    <b-button type="is-primary" @click.prevent="onClickAddButton">Add</b-button>
  </div>
</template>

<script>
import ListItems from '@/components/item/ListItems.vue';
import CreateItemModal from '@/modals/CreateItemModal.vue';

export default {
  name: 'Home',
  components: { ListItems, CreateItemModal },
  methods: {
    onClickAddButton() {
      this.$modal.show('create-item-modal');
    },
  },
};
</script>
