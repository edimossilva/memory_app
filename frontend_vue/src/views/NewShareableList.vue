<template>
  <div data-cy="list_shareable_list">
    <div class="columns m-6">
      <div class="column is-6 notification is-info mr-4">
        <draggable
          class="list-group columns is-multiline"
          :list="allItems"
          group="item"
          @change="log"
          v-bind:class="{
            'new-shareable-list__items_empty': allItems.length === 0,
          }"
        >
          <div
            class="list-group-item column is-half"
            v-for="item in items"
            :key="item.key"
          >
            <draggable-item :item="item"></draggable-item>
          </div>
        </draggable>
      </div>
      <div class="column is-6 notification is-info ml-4 mb-5 h-auto">
        <draggable
          class="list-group columns is-multiline"
          :list="shareableList.items"
          group="item"
          @change="log"
          v-bind:class="{
            'new-shareable-list__items_empty': shareableList.items.length === 0,
          }"
        >
          <div
            class="list-group-item column is-half"
            v-for="item in shareableList.items"
            :key="item.key"
          >
            <draggable-item :item="item"></draggable-item>
          </div>
        </draggable>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import DraggableItem from "@/components/shareable_list/DraggableItem.vue";
import { getItemsApi } from "../services/itemsApi";
import draggable from "vuedraggable";

export default {
  name: "NewShareableItem",
  components: { DraggableItem, draggable },
  mounted() {
    getItemsApi().then(
      (response) => {
        this.setItems(response.data.data);
        this.allItems = response.data.data;
      },
      (error) => {
        console.log(error);
      }
    );
  },
  data() {
    return {
      allItems: [],
      shareableList: { name: "", items: [] },
    };
  },
  computed: {
    ...mapState(["items"]),
  },
  methods: {
    ...mapActions(["setItems"]),
    add: function () {
      console.log("add");
    },
    replace: function () {
      console.log("replace");
    },
    clone: function (el) {
      return {
        name: el.name + " cloned",
      };
    },
    log: function (evt) {
      window.console.log(evt);
    },
  },
};
</script>
<style>
.h-auto {
  height: auto;
}
.new-shareable-list__items_empty {
  height: 100%;
}
</style>
