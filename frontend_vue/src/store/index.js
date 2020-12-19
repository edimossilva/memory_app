import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    isLogged: {},
    items: [],
    modalItem: {},
    shareableLists: [],
    tags: [],
  },
  mutations: {
    addElement(state, { property, element }) {
      state[property].push(element);
    },
    removeElement(state, { property, element }) {
      const index = state[property].findIndex((i) => i.id === element.id);
      state[property].splice(index, 1);
    },
    editElement(state, { property, element }) {
      const foundItem = state[property].find((i) => i.id === element.id);
      Object.assign(foundItem, element);
    },
    mutate(state, { property, value }) {
      state[property] = value;
    },
  },
  actions: {
    addItem({ commit }, item) {
      commit("addElement", { property: "items", element: item });
    },
    addTag({ commit }, tag) {
      commit("addElement", { property: "tags", element: tag });
    },
    removeItem({ commit }, item) {
      commit("removeElement", { property: "items", element: item });
    },
    removeTag({ commit }, tag) {
      commit("removeElement", { property: "tags", element: tag });
    },
    removeShareableList({ commit }, shareableList) {
      commit("removeElement", {
        property: "shareableLists",
        element: shareableList,
      });
    },
    setItems({ commit }, items) {
      commit("mutate", { property: "items", value: items });
    },
    setTags({ commit }, tags) {
      commit("mutate", { property: "tags", value: tags });
    },
    setShareableLists({ commit }, shareableLists) {
      commit("mutate", { property: "shareableLists", value: shareableLists });
    },
    editItem({ commit }, item) {
      commit("editElement", { property: "items", element: item });
    },
    editTag({ commit }, tag) {
      commit("editElement", { property: "tags", element: tag });
    },
    setIsLogged({ commit }, isLogged) {
      commit("mutate", { property: "isLogged", value: isLogged });
    },
    setModalItem({ commit }, modalItem) {
      commit("mutate", { property: "modalItem", value: modalItem });
    },
  },
  modules: {},
});
