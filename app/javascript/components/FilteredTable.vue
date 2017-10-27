<template>
  <div>
    <table>
      <row v-for="item, key in items" 
        :key="key"
        :item="item">
      </row>
    </table>

    <pagination :items-per-page="config.itemsPerPage" :total-items="totalItems"></pagination>
  </div>  
</template>

<script>
  import { eventHub } from '../home.js'
  import Row from './table/Row.vue'
  import Pagination from './pagination/Pagination.vue'

  export default {
    name: 'filtered-table',

    components: { Row, Pagination },

    props: {
      projects: { type: Array }
    },

    data () {
      return {
        config: {
          itemsPerPage: 2
        },
        items: [],
        totalItems: this.projects.length,
        itemsOnCurrentPage: []
      }
    },

    created () {
      this.items = this.projects
    },

    mounted () {
      // refilter the items when the filters are changed

      // repaginate the items when the previous/next buttons are clicked
      eventHub.$on('pageChanged', this.paginateItems)

      // only display the items that match the page number
      this.filterItems()
    },

    methods: {
      filterItems () {
        this.$store.commit('clearActiveItems')

        //create array of ids of items that match the selected filters
        this.items.forEach(item => {
          this.$store.commit('updateActiveItems', item.id)
        })

        this.paginateItems()
        this.$store.commit('updateCurrentPage', 1)
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
      