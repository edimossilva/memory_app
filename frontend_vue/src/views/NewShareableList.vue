<template>
  <div>
    <div class="columns mx-6 mt-2">
      <div class="column is-6">
        <div class="columns is-multiline">
          <div class="column mt-6 mb-1"></div>
          <div class="column is-12 notification is-info mr-4 mb-0">
            <h2 class="is-size-3 notification p-1 is-primary">All Items</h2>
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
        </div>
      </div>
      <div class="column is-6 notification is-secondary ml-4 pb-0">
        <div class="columns is-multiline">
          <div class="column is-12">
            <b-field label="Name" label-position="inside" type="is-primary">
              <b-input
                type="text"
                v-model="shareableList.name"
                data-cy="new-shareable-list__name_input"
              ></b-input>
            </b-field>
          </div>
        </div>
        <div class="columns is-multiline mb-0">
          <div class="column notification is-info mx-2 mb-2 h-auto">
            <h2 class="is-size-3 notification p-1 is-primary">Items</h2>
            <draggable
              class="list-group columns is-multiline"
              :list="shareableList.items"
              group="item"
              @change="log"
              v-bind:class="{
                'new-shareable-list__items_empty':
                  shareableList.items.length === 0,
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
        <div class="columns is-multiline mb-0">
          <div class="column mx-2 mb-0 h-auto">
            <b-field>
              <b-button
                class="m-2"
                @click="onConfirm()"
                type="is-primary"
                data-cy="item_modal__confirm_button"
                icon-left="plus"
              >
                Create list
              </b-button>
            </b-field>
          </div>
        </div>
        <div class="new-shareable-list__button-container"></div>
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
.new-shareable-list__selected_items {
  height: 100%;
}
.new-shareable-list__name_column {
  height: 100%;
}
.new-shareable-list__button-container {
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
}
</style>
