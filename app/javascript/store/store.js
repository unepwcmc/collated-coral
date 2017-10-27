import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'

Vue.use(Vuex)

// create store
export default new Vuex.Store({
  state: {
    items: [], //contains project objects
    activeItems: [], // contains indices of articles which match the filters
    itemsPerPage: 0,
    currentPage: 1
  },

  mutations: {
    updateItems (state, items) {
      this.state.items = items 
    },

    updateActiveItems (state, item) {
      this.state.activeItems.push(item)
    },

    clearActiveItems () {
      this.state.activeItems = []
    },

    updateItemsPerPage (state, total) {
      this.state.itemsPerPage = total
    },

    updateCurrentPage (state, currentPage) {
      this.state.currentPage = currentPage
    }
  }
})
