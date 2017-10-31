<template>
  <div>
    <div>
      selected filters
      <div>
        <selected-filter v-for="selectedFilterOption, index in selectedFilterOptions"
          :index="index"
          :name="selectedFilterOption.name"
          :option="selectedFilterOption.option"
        ></selected-filter>
      </div>
    </div>

    <table>
      <filters :filters="filters"></filters>

      <row v-for="item, key in items" 
        :key="key"
        :item="item">
      </row>
    </table>

    <pagination :items-per-page="config.itemsPerPage"></pagination>
  </div>  
</template>

<script>
  import { eventHub } from '../home.js'
  import Filters from './filters/Filters.vue'
  import SelectedFilter from './filters/SelectedFilter.vue'
  import Row from './table/Row.vue'
  import Pagination from './pagination/Pagination.vue'

  export default {
    name: 'filtered-table',

    components: { SelectedFilter, Filters, Row, Pagination },

    props: {
      filters: { type: Array },
      projects: { type: Array }
    },

    data () {
      return {
        config: {
          itemsPerPage: 2
        },
        items: [],
        // totalItems: this.projects.length,
        itemsOnCurrentPage: [],
        selectedFilterOptions: this.$store.state.selectedFilterOptions,
      }
    },

    created () {
      this.items = this.projects
      this.$store.commit('updateTotalItems', this.items.length)

      this.filters.forEach(filter => {
        // console.log(filter)
      })

      this.$store.commit('updateFilters', this.filters)
    },

    computed: {
      totalItems () {
        return this.$store.state.activeItems.length
      }
    },

    mounted () {
      // refilter the items when the filters are changed
      eventHub.$on('filtersChanged', this.filterItems)

      // repaginate the items when the previous/next buttons are clicked
      eventHub.$on('pageChanged', this.paginateItems)

      // only display the items that match the page number
      this.filterItems()
    },  

    methods: {
      filterItems () {
        this.$store.commit('clearActiveItems')

        //create array of ids of items that match ALL selected filters
        this.items.forEach(item => {
          let fails = 0

          // if the active filter does not match then increment fails
          this.$store.state.selectedFilterOptions.forEach(filter => {
            // console.log('filter', filter.name)
            // console.log('filter', filter.option)
            // console.log('item', item[filter.name])
            if(item[filter.name] != filter.option) fails ++
          })

          // only push the item id into the active items array if there are no fails
          if(fails == 0){
            this.$store.commit('updateActiveItems', item.id)
          }
        })

        // console.log('active items in main', this.$store.state.activeItems)
        this.paginateItems()
        this.$store.commit('updateCurrentPage', 1)
        this.$store.commit('updateTotalItems', this.$store.state.activeItems.length)
        eventHub.$emit('activeItemsChanged');
      },

      // only display the items that match the page number
      paginateItems () {
        const pageStart = (this.$store.state.currentPage - 1) * this.config.itemsPerPage
        const pageEnd =  pageStart + this.config.itemsPerPage;

        this.itemsOnCurrentPage = this.$store.state.activeItems.slice(pageStart, pageEnd)

        // loop through all articles and update the active state
        this.items.forEach(item => {
          
          const isActive = this.itemsOnCurrentPage.indexOf(item.id) >= 0
          
          this.$set(item, 'isActive', isActive)
        })
      }
    }
  }
</script>

<style>
  
</style>
      