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
              @select="(option) => addTagByName(option)"
              dropdown-position="top"
              :open-on-focus="true"
              :clear-on-select="true"
              data-cy="item_modal__tag_autocomplete"
            >
              <template v-slot:footer>
                <a @click="isTagModalActive = true">
                  <span data-cy="item_modal__add_new_tag">
                    Add new tag...
                  </span>
                </a>
              </template>
            </b-autocomplete>
          </b-field>
          <div class="columns m-2">
            <div class="column">
              <b-tag
                v-for="tag in item.tags"
                :key="tag.id"
                type="is-light"
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
      <b-modal
        v-model="isTagModalActive"
        has-modal-card
        trap-focus
        :destroy-on-hide="true"
        aria-role="dialog"
        aria-modal
      >
        <template #default="props">
          <tag-modal
            titleLabel="Create tag"
            buttonLabel="Save"
            :errorMessage="tagModalErrorMessage"
            :onConfirmClick="onCreateTagConfirmButtonClick"
            @close="props.close"
          ></tag-modal>
        </template>
      </b-modal>
    </div>
  </form>
</template>

<script>
import { mapState, mapActions } from "vuex";
import { createTagApi } from "../services/tagsApi";
import TagModal from "@/modals/TagModal.vue";

export default {
  name: "ItemModal",
  components: { TagModal },
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
      isTagModalActive: false,
      tagModalErrorMessage: "",
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
    ...mapActions(["addTag"]),
    onCreateTagConfirmButtonClick(tag) {
      createTagApi(tag).then(
        (response) => {
          this.addTag(response.data.data);
          this.addTagByName(response.data.data.name);
          this.isTagModalActive = false;
        },
        (error) => {
          this.tag = {};
          this.tagModalErrorMessage = error.response.data.error_message;
        }
      );
    },
    addTagByName(selectedTagName) {
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
