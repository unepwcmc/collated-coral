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
    selectedFilterOptions: [], // an array containing an object for each filter that has an array of selected options
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

    updateFilterOptions (state, options) {
      this.state.selectedFilterOptions = options
    },

    addFilterOption (state, option) {
      this.state.selectedFilterOptions.forEach(filter => {
        if(filter.name == option.name){ filter.options.push(option.option)}
      })
    },

    removeFilterOption (state, removeOption) {

      this.state.selectedFilterOptions.forEach(filter => {
        if(filter.name == removeOption.name){ 
          filter.options.forEach(option => {
            if(option == removeOption.option){
              const index = filter.options.indexOf(removeOption.option)

              filter.options.splice(index, 1)
            }
          })
        }
      })
    },

    updateFilters (state, filters) {
      this.state.filters = filters
    },

    updateTotalPages (state, total) {
      this.state.totalPages = total
    }
  }
})
