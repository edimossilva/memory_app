<template>
  <div data-cy="list_items">
    <div class="mb-4">
      <b-field label="search" label-position="inside" type="is-primary">
        <b-input
          type="text"
          v-model="filter"
          data-cy="list_items__filter_input"
        ></b-input>
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
import { mapState, mapActions } from "vuex";
import ShowItem from "@/components/item/ShowItem.vue";
import { getItemsApi } from "../../services/itemsApi";

export default {
  name: "ListItems",
  mounted() {
    getItemsApi().then(
      (response) => {
        this.setItems(response.data.data);
      },
      (error) => {
        console.log(error);
      }
    );
  },
  data() {
    return {
      item: { key: "", value: "" },
      filter: "",
    };
  },
  components: { ShowItem },
  computed: {
    ...mapState(["items"]),
    filteredItems() {
      const { items, filter } = this;
      if (filter) return items.filter((item) => item.key.includes(filter));
      return items;
    },
  },
  methods: {
    ...mapActions(["setItems"]),
  },
};
</script>
