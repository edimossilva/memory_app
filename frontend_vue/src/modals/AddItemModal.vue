<template>
  <form action="">
    <div name="create-item-modal" class="modal-card" style="width: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">Add memory</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body">
        <p v-if="errorMessage" class="help is-danger mb-4">
          {{ errorMessage }}
        </p>

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
        <b-field>
          <b-button
            class="m-2"
            @click="onCreateButtonClick()"
            type="is-primary"
            data-cy="addButton"
            outlined
            >Add</b-button
          >
        </b-field>
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
      errorMessage: "",
    };
  },
  methods: {
    ...mapActions(["addItem"]),
    onCreateButtonClick() {
      createItemApi(this.item).then(
        (response) => {
          this.addItem(response.data.data);
          this.item = {};
          this.$emit("close");
        },
        (error) => {
          // this.showError();
          this.item = {};
          this.errorMessage = error.response.data.error_message;
        }
      );
    },
  },
};
</script>
