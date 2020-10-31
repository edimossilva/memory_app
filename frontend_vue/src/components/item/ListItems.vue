<template>
  <div>
    <div class="mb-4">
      <b-field label="search" label-position="inside" type="is-primary">
        <b-input type="text" v-model="filter" data-cy="filter"></b-input>
      </b-field>
    </div>
    <div class="columns is-multiline is-mobile">
      <div class="column is-half" v-for="item in filteredItems" :key="item.key">
        <show-item :item="item"></show-item>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import ShowItem from '@/components/item/ShowItem.vue';
export default {
  name: 'ListItems',
  data() {
    return {
      item: { key: '', value: '' },
      filter: '',
    };
  },
  components: { ShowItem },
  computed: {
    ...mapState(['items']),
    filteredItems() {
      const { items, filter } = this;
      if (filter) return items.filter((item) => item.key.includes(filter));
      return items;
    },
  },
};
</script>
