<template>
  <div data-cy="list_items">
    <div class="mb-6">
      <b-field type="is-primary">
        <b-input
          placeholder="Search..."
          v-model="filter"
          type="search"
          icon-pack="fas"
          icon="search"
          data-cy="list_items__filter_input"
          custom-class="is-primary has-background-white"
        >
        </b-input>
      </b-field>
    </div>
    <slot></slot>
    <div class="columns is-multiline">
      <div
        class="column is-one-third"
        v-for="item in filteredItems"
        :key="item.key"
      >
        <show-item
          :item="item"
          :copy-only="copyOnly"
          :queries="[filter]"
        ></show-item>
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
    if (this.externalItems) {
      this.setItems(this.externalItems);
      return;
    }
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
  props: {
    copyOnly: { type: Boolean, required: false, default: false },
    externalItems: { type: Array, required: false },
  },
  components: { ShowItem },
  computed: {
    ...mapState(["items"]),
    filteredItems() {
      const { items, filter } = this;
      if (filter)
        return items.filter(
          (item) =>
            item.key.toLowerCase().includes(filter.toLowerCase()) ||
            item.value.toLowerCase().includes(filter.toLowerCase())
        );
      return items;
    },
  },
  methods: {
    ...mapActions(["setItems"]),
  },
  watch: {
    externalItems: function (newVal) {
      this.setItems(newVal);
    },
  },
};
</script>
