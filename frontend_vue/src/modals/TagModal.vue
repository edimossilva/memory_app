<template>
  <form action="">
    <div name="create-tag-modal" class="modal-card" style="width: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ titleLabel }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body">
        <p
          v-if="errorMessage"
          class="help is-danger mb-4"
          data-cy="tag_modal__error_message"
        >
          {{ errorMessage }}
        </p>

        <b-field
          label="Name"
          label-position="inside"
          type="is-primary"
          class="mx-4"
        >
          <b-input
            @keyup.enter.native="onConfirmClick"
            type="text"
            v-model="tag.name"
            data-cy="tag_modal__name_input"
          ></b-input>
        </b-field>

        <b-field>
          <b-button
            class="m-2"
            @click="onConfirmClick(tag)"
            type="is-primary"
            data-cy="tag_modal__confirm_button"
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
  name: "TagModal",
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
    initialTag: {
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
      tag: { name: "" },
    };
  },
  mounted() {
    if (this.initialTag) {
      Object.assign(this.tag, this.initialTag);
    } else {
      this.tag = {};
    }
  },
};
</script>
