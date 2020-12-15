<template>
  <div>
    <div
      class="card has-background-info"
      :data-cy="`show_shareable_list__card_${shareableList.name}`"
    >
      <header class="card-header">
        <p class="card-header-title is-centered">
          {{ shareableList.name }}
        </p>
      </header>
      <div class="card-content">
        <div class="content columns is-multiline">
          <div
            class="column is-one-third pb-0"
            v-for="item in items"
            :key="item.key"
          >
            <show-item :item="item" :hide-content="true"></show-item>
          </div>
        </div>
      </div>
      <footer class="card-footer">
        <a
          class="card-footer-item has-text-danger"
          :data-cy="`show_shareable_list__delete_button_${shareableList.name}`"
          @click.prevent="onRemoveButtonClick"
        >
          <b-icon icon="trash-alt" size="is-small"> </b-icon>
        </a>
      </footer>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";
import { deleteShareableListApi } from "../../services/shareableListsApi";
import {
  successNotify,
  dangerNotify,
} from "../../services/notifications/notificationsService";
import ShowItem from "@/components/item/ShowItem.vue";

export default {
  name: "ShowShareableList",
  components: { ShowItem },
  props: {
    shareableList: { type: Object, required: true },
  },
  data() {
    return {
      shareableListModalErrorMessage: "",
    };
  },
  computed: {
    items() {
      const items = this.shareableList.memories;
      return items;
    },
  },
  methods: {
    ...mapActions(["removeShareableList"]),
    onRemoveButtonClick() {
      this.$buefy.dialog.confirm({
        message: `Are you sure you want to <b>DELETE</b> "${this.shareableList.name}"?`,
        confirmText: "Delete",
        type: "is-danger",
        onConfirm: () => this.deleteItem(),
      });
    },
    deleteItem() {
      deleteShareableListApi(this.shareableList.id).then(
        () => {
          this.removeShareableList(this.shareableList);
          successNotify(this.$buefy, `"${this.shareableList.name}" deleted`);
        },
        (error) => {
          console.log(error.response.data.error_message);
          dangerNotify(this.$buefy, error.response.data.error_message);
        }
      );
    },
  },
};
</script>
