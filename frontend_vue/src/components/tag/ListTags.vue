<template>
  <div data-cy="list_tags">
    <div class="columns is-multiline">
      <div class="column is-one-third" v-for="tag in tags" :key="tag.key">
        <show-tag :tag="tag"></show-tag>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import ShowTag from "@/components/tag/ShowTag.vue";
import { getTagsApi } from "../../services/tagsApi";

export default {
  name: "ListTags",
  components: { ShowTag },
  mounted() {
    getTagsApi().then(
      (response) => {
        this.setTags(response.data.data);
      },
      (error) => {
        console.log(error);
      }
    );
  },
  data() {
    return {
      tag: { key: "", value: "" },
      filter: "",
    };
  },
  computed: {
    ...mapState(["tags"]),
  },
  methods: {
    ...mapActions(["setTags"]),
  },
};
</script>
