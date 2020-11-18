<template>
  <form action="">
    <div
      name="create-item-modal"
      class="modal-card"
      style="width: auto, height:auto"
    >
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
            @keyup.enter.native="onConfirm()"
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
            @keyup.enter.native="onConfirm()"
            type="text"
            v-model="item.value"
            data-cy="item_modal__value_input"
          ></b-input>
        </b-field>
        <section>
          <b-field
            label="*Tags"
            label-position="inside"
            type="is-primary"
            class="mx-4"
          >
            <b-autocomplete
              v-model="tagName"
              ref="autocomplete"
              :data="filteredTagsArray"
              @select="(option) => addTag(option)"
              dropdown-position="top"
              :open-on-focus="true"
              :clear-on-select="true"
              data-cy="item_modal__tag_autocomplete"
            >
              <!-- <template slot="footer">
            <a @click="showAddFruit">
              <span> Add new... </span>
            </a>
          </template>
          <template slot="empty">Tag</template> -->
            </b-autocomplete>
          </b-field>
          <div class="columns mx-4">
            <div class="column">
              <b-tag
                v-for="tag in item.tags"
                :key="tag.id"
                type="is-info"
                closable
                aria-close-label="Close tag"
                @close="removeTag(tag)"
                :data-cy="`item_modal__tag_spam_${tag.name}`"
                class="is-medium mx-2"
              >
                {{ tag.name }}
              </b-tag>
            </div>
          </div>
        </section>
        <b-field>
          <b-button
            class="m-2"
            @click="onConfirm()"
            type="is-primary"
            data-cy="item_modal__confirm_button"
            icon-left="save"
            outlined
          >
            {{ buttonLabel }}
          </b-button>
        </b-field>
      </section>
    </div>
  </form>
</template>

<script>
import { mapState } from "vuex";

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
      item: {},
      tagName: "",
      selected: null,
    };
  },

  mounted() {
    if (this.initialItem) {
      this.item = { ...this.initialItem };
    } else {
      this.item = { key: "", value: "", tags: [] };
    }
  },
  computed: {
    ...mapState(["tags"]),
    allTagsNames() {
      return this.tags.map((tag) => tag.name);
    },
    itemTagsNames() {
      if (this.item.tags) return this.item.tags.map((tag) => tag.name);
      return [];
    },
    filteredTagsArray() {
      const { subArrays, allTagsNames, itemTagsNames, tagName } = this;

      return subArrays(allTagsNames, itemTagsNames).filter((typedValue) => {
        const searchValue = typedValue.toString().toLowerCase();
        return searchValue.indexOf(tagName.toLowerCase()) >= 0;
      });
    },
  },
  methods: {
    addTag(selectedTagName) {
      if (!selectedTagName) {
        return;
      }
      const selectedTag = this.tags.find((tag) => tag.name == selectedTagName);
      this.item.tags.push(selectedTag);
      this.item = { ...this.item };
    },
    removeTag(tag) {
      const index = this.item.tags.indexOf(tag);
      this.item.tags.splice(index, 1);
      this.item = { ...this.item };
    },
    subArrays(array1, array2) {
      return array1.filter((item1) => {
        return !array2.some((item2) => {
          return item2 === item1;
        });
      });
    },
    showAddFruit() {
      this.$buefy.dialog.prompt({
        message: `Fruit`,
        inputAttrs: {
          placeholder: "e.g. Watermelon",
          maxlength: 20,
          value: this.name,
        },
        confirmText: "Add",
        onConfirm: (value) => {
          this.data.push(value);
          this.$refs.autocomplete.setSelected(value);
        },
      });
    },
    onConfirm() {
      this.onConfirmClick(this.item);
    },
  },
};
</script>
