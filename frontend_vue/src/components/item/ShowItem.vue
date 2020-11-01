<template>
  <div>
    <div class="card">
      <div class="card-content">
        <div class="content">{{ item.key }}: {{ item.value }}</div>
      </div>
      <footer class="card-footer">
        <a
          class="card-footer-item"
          :dataId="item.key"
          @click.prevent="onCopyButtonClick"
        >
          Copy
        </a>
        <a
          class="card-footer-item has-text-danger"
          :dataId="item.key"
          @click.prevent="onRemoveButtonClick"
        >
          Remove
        </a>
      </footer>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";
import { deleteItemApi } from "../../services/itemsApi";

export default {
  name: "ShowItem",
  props: {
    item: { type: Object, required: true },
  },
  components: {},
  methods: {
    ...mapActions(["removeItem"]),
    onRemoveButtonClick() {
      deleteItemApi(this.item.id).then(
        () => {
          this.removeItem(this.item);
        },
        (error) => {
          // this.showError();
          console.log(error.response.data.error_message);
        }
      );
    },
    onCopyButtonClick() {
      const { item, $copyText, $buefy } = this;
      $copyText(item.value).then(() => {
        $buefy.dialog.alert({
          message: `"${item.value}" copied to clipboard :)`,
          type: "is-primary",
          ariaRole: "alertdialog",
          ariaModal: true,
        });
      });
    },
  },
};
</script>
