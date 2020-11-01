<template>
  <form action="">
    <div name="create-item-modal" class="modal-card" style="width: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">Add memory</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body">
        <b-field
          label="Key"
          label-position="inside"
          type="is-primary"
          class="mx-4"
        >
          <b-input
            @keyup.enter.native="onCreateButtonClick"
            type="text"
            v-model="item.key"
            data-cy="key"
          ></b-input>
        </b-field>

        <b-field
          label="Value"
          label-position="inside"
          type="is-primary"
          class="mx-4"
        >
          <b-input
            @keyup.enter.native="onCreateButtonClick"
            type="text"
            v-model="item.value"
            data-cy="value"
          ></b-input>
        </b-field>

        <b-button
          class="m-2"
          @click="onCreateButtonClick()"
          type="is-primary"
          data-cy="addButton"
          outlined
          >Add</b-button
        >
      </section>
    </div>
  </form>
</template>

<script>
import { mapActions } from "vuex";
import { createItemApi } from "../services/itemsApi";

export default {
  name: "AddItemModal",
  data() {
    return {
      item: { key: "", value: "" },
    };
  },
  methods: {
    ...mapActions(["addItem"]),
    onCreateButtonClick() {
      createItemApi(this.item).then(
        () => {
          this.addItem(this.item);
          this.item = {};
          this.$emit("close");
        },
        (error) => {
          // this.showError();
          console.error(error.response.data.error_message);
        }
      );
    },
  },
};
</script>
