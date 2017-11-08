<template>
  <div>
    <a :href="postIds" class="button button--download button--red filter__download" title="Download CSV file of filtered Coral projects">Download CSV</a>

    <h3>Filters</h3>
    
    <filters :filters="filters"></filters>

    <div class="selected">
      <h3>Selected filters</h3>
      <div>
        <selected-filter v-for="selectedFilterOption in selectedFilterOptions"
          :name="selectedFilterOption.name"
          :option="selectedFilterOption.option"
        ></selected-filter>
      </div>
    </div>
    
    <h3>Results</h3>

    <table>
      <thead>
        <tr>
          <th v-for="filter in filters">{{ filter.title }}</th>
        </tr>
      </thead>

      <tbody>
        <row v-for="item, key in items"
          :key="key"
          :item="item">
        </row>
      </tbody>
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
          itemsPerPage: 5
        },
        items: [],
        itemsOnCurrentPage: []
      }
    },

    created () {
      this.createSelectedFilterOptions()
      this.items = this.projects
      this.$store.commit('updateTotalItems', this.items.length)
      this.$store.commit('updateFilters', this.filters)
    },

    mounted () {
      // refilter the items when the filters are changed
      eventHub.$on('filtersChanged', this.filterItems)

      // repaginate the items when the previous/next buttons are clicked
      eventHub.$on('pageChanged', this.paginateItems)

      // sort the active items when a sort button is clicked
      eventHub.$on('sort', this.sortActiveItems)

      // only display the items that match the page number
      this.filterItems()
    },

    computed: {
      selectedFilterOptions () {
        // return selected filter options in an appropriate format to loop over
        let options = []

        this.$store.state.selectedFilterOptions.forEach(filter => {
          if (filter.options.length !== 0) {
            filter.options.forEach(selectedOption => {
              let obj = {}

              obj.name = filter.name
              obj.option = selectedOption

              options.push(obj)
            })
          }
        })

        return options
      },

      postIds () {
        let url = '/download'

        this.$store.state.activeItems.forEach((item, index) => {
          let string = (index == 0) ? '?' : '&'
          
          string += 'ids[]=' + item
          url += string
        })

        return url
      }
    },

    methods: {
      filterItems () {
        this.$store.commit('clearActiveItems')

        // an item must match one option from each filter (if any have been selected)
        this.items.forEach(item => {
          let filterMatch = true

          this.$store.state.selectedFilterOptions.forEach(filter => {

            // if there are some selected options check to see if one matches
            if (filter.options.length !== 0) {
              let optionMatch = false

              filter.options.forEach(option => {
                if (item[filter.name] == option) optionMatch = true
              })

              // once filterMatch is set to false it will always be false and the item
              // will not be shown because it did match an option in one of the filters
              filterMatch = filterMatch && optionMatch
            }
          })

          // only push the item id into the active items array if there are no fails
          if (filterMatch) {
            this.$store.commit('updateActiveItems', item.id)
          }
        })

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
      },

      createSelectedFilterOptions () {
        let array = []

        // create an empty array for each filter
        this.filters.forEach(filter => {
          if (filter.name !== undefined && filter.options.length > 0) {
            let obj = {}

            obj.name = filter.name,
            obj.options = []

            array.push(obj)
          }
        })

        this.$store.commit('updateFilterOptions', array)
      },

      sortActiveItems (sort) {
        // sort the items using the main array the contains all data
        this.items.sort(this.compare())

        // trigger filtering function so that the active items array is updated with 
        // the new order and the results are paginated correctly
        this.filterItems()
      },

      compare () {
        // use a negative to flip the order if the button is descending
        let order = (this.$store.state.sortDirection.substr(0, 1) === '+') ? 1 : -1

        let filter = this.$store.state.sortDirection.substr(1)
        
        // order the items using the correct property
        return function (a, b) {
          let result = (a[filter] < b[filter]) ? -1 : (a[filter] > b[filter]) ? 1 : 0;
          return result * order;
        }
      }
    }
  }
</script>
