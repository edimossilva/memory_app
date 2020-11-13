import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    items: [],
    tags: [],
    isLogged: {},
  },
  mutations: {
    addItem(state, item) {
      state.items.push(item);
    },
    addTag(state, tag) {
      state.tags.push(tag);
    },
    removeItem(state, item) {
      const index = state.items.findIndex((i) => i.key === item.key);
      state.items.splice(index, 1);
    },
    removeTag(state, tag) {
      const index = state.items.findIndex((i) => i.key === tag.key);
      state.tags.splice(index, 1);
    },
    editItem(state, updatedItem) {
      const foundItem = state.items.find((item) => item.id === updatedItem.id);
      Object.assign(foundItem, updatedItem);
    },
    editTag(state, updatedTag) {
      const foundTag = state.tags.find((item) => item.id === updatedTag.id);
      Object.assign(foundTag, updatedTag);
    },
    mutate(state, { property, value }) {
      state[property] = value;
    },
  },
  actions: {
    addItem({ commit }, item) {
      commit("addItem", { ...item });
    },
    addTag({ commit }, tag) {
      commit("addTag", { ...tag });
    },
    removeItem({ commit }, item) {
      commit("removeItem", item);
    },
    removeTag({ commit }, tag) {
      commit("removeTag", tag);
    },
    setItems({ commit }, items) {
      commit("mutate", { property: "items", value: items });
    },
    setTags({ commit }, tags) {
      commit("mutate", { property: "tags", value: tags });
    },
    editItem({ commit }, item) {
      commit("editItem", item);
    },
    editTag({ commit }, tag) {
      commit("editTag", tag);
    },
    setIsLogged({ commit }, isLogged) {
      commit("mutate", { property: "isLogged", value: isLogged });
    },
  },
  modules: {},
});
