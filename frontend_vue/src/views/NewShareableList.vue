<template>
  <div data-cy="list_shareable_list">
    <div class="columns m-6">
      <div class="column is-6 notification is-info mr-4">
        <div class="columns is-multiline">
          <div class="column is-half" v-for="item in items" :key="item.key">
            <draggable-item :item="item"></draggable-item>
          </div>
        </div>
      </div>
      <div class="column is-6 notification is-info ml-4">
        <div class="columns is-multiline">
          <div class="column is-half" v-for="item in items" :key="item.key">
            <draggable-item :item="item"></draggable-item>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import DraggableItem from "@/components/shareable_list/DraggableItem.vue";
import { getItemsApi } from "../services/itemsApi";

export default {
  name: "NewShareableItem",
  components: { DraggableItem },
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
      shareableList: { name: "", items: [] },
    };
  },
  computed: {
    ...mapState(["items"]),
  },
  methods: {
    ...mapActions(["setItems"]),
  },
};
</script>
