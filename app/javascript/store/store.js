import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'

Vue.use(Vuex)

// create store
export default new Vuex.Store({
  state: {
    totalItems: [], // contains project objects
    activeItems: [], // contains indices of articles which match the filters
    itemsPerPage: 0,
    totalPages: 0,
    currentPage: 1,
    selectedFilterOptions: [], // contains strings for the name of each filter option selected
    filters: []
  },

  mutations: {
    updateTotalItems (state, total) {
      this.state.totalItems = total 
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
    },

    addFilterOption (state, option) {
      this.state.selectedFilterOptions.push(option)
    },

    removeFilterOption (state, index) {
      this.state.selectedFilterOptions.splice(index, 1)
    },

    updateFilters (state, filters) {
      this.state.filters = filters
    },

    updateTotalPages (state, total) {
      this.state.totalPages = total
    }
  }
})
