<template>
  <form action="">
    <div name="create-item-modal" class="modal-card" style="width: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ titleLabel }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body">
        <p
          v-if="errorMessage"
          class="help is-danger mb-4"
          data-cy="item_modal__error_message"
        >
          {{ errorMessage }}
        </p>

        <b-field
          label="Key"
          label-position="inside"
          type="is-primary"
          class="mx-4"
        >
          <b-input
            @keyup.enter.native="onConfirmClick"
            type="text"
            v-model="item.key"
            data-cy="item_modal__key_input"
          ></b-input>
        </b-field>

        <b-field
          label="Value"
          label-position="inside"
          type="is-primary"
          class="mx-4"
        >
          <b-input
            @keyup.enter.native="onConfirmClick"
            type="text"
            v-model="item.value"
            data-cy="item_modal__value_input"
          ></b-input>
        </b-field>

        <b-field>
          <b-button
            class="m-2"
            @click="onConfirmClick(item)"
            type="is-primary"
            data-cy="item_modal__confirm_button"
            icon-left="save"
            outlined
          >
            {{ buttonLabel }}</b-button
          >
        </b-field>
      </section>
    </div>
  </form>
</template>

<script>
export default {
  name: "ItemModal",
  props: {
    titleLabel: {
      type: String,
      required: true,
    },
    buttonLabel: {
      type: String,
      required: true,
    },
    errorMessage: {
      type: String,
      required: true,
    },
    initialItem: {
      type: Object,
      required: false,
    },
    onConfirmClick: {
      type: Function,
      required: true,
    },
  },
  data() {
    return {
      item: { key: "", value: "" },
    };
  },
  mounted() {
    if (this.initialItem) {
      Object.assign(this.item, this.initialItem);
    } else {
      this.item = {};
    }
  },
};
</script>
