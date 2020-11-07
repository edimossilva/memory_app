import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    items: [],
  },
  mutations: {
    addItem(state, item) {
      state.items.push(item);
    },
    removeItem(state, item) {
      const index = state.items.findIndex((i) => i.key === item.key);
      state.items.splice(index, 1);
    },
    setItems(state, items) {
      state.items = items;
    },
    editItem(state, updatedItem) {
      const foundItem = state.items.find((item) => item.id === updatedItem.id);
      Object.assign(foundItem, updatedItem);
    },
    // mutate(state, payload) {
    //   state[payload.property] = payload.value;
    // },
  },
  actions: {
    addItem({ commit }, item) {
      commit("addItem", { ...item });
    },
    removeItem({ commit }, item) {
      commit("removeItem", item);
    },
    setItems({ commit }, items) {
      commit("setItems", items);
    },
    editItem({ commit }, item) {
      commit("editItem", item);
    },
  },
  modules: {},
});
