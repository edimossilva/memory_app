<template>
  <div class="h-100">
    <div
      class="card bm--card-equal-height"
      :data-cy="`draggable_item__card_${item.key}`"
    >
      <header class="card-header">
        <p class="card-header-title is-centered">
          {{ item.key }}
        </p>
      </header>
      <div class="card-content h-100">
        <div class="content h-100 has-text-black">
          <a
            v-if="isUrl"
            :href="item.value"
            :data-cy="`draggable_item__a_${item.key}`"
            target="_blank"
          >
            {{ item.value }}
          </a>
          <div v-else>
            {{ item.value }}
          </div>
        </div>
        <div class="tags is-centered">
          <span
            v-for="tag in item.tags"
            :key="tag.id"
            class="tag is-light"
            :data-cy="`draggable_item__tag_${tag.name}`"
          >
            {{ tag.name }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "DraggabkeItem",
  props: {
    item: { type: Object, required: true },
  },

  data() {
    return {
      isComponentModalActive: false,
      itemModalErrorMessage: "",
    };
  },
  computed: {
    isUrl() {
      const { item } = this;
      if (item.value.includes("http://") || item.value.includes("https://")) {
        return true;
      }
      return false;
    },
  },
  methods: {},
};
</script>
<style lang="css" scoped>
.h-100 {
  height: 100%;
}
.bm--card-equal-height {
  display: flex;
  flex-direction: column;
  height: 100%;
}
.bm--card-equal-height .card-footer {
  margin-top: auto;
}
.card-content {
  display: flex;
  flex-direction: column;
}
.content {
  width: 100%;
}
</style>
