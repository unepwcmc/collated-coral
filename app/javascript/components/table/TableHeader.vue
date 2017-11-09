<template>
  <th>
    <span>{{ filter.title }}</span>

    <div v-if="hasOptions" class="filter__sorting">
        <button @click="sort('+')" class="filter__sort filter__sort--ascending"></button>
        <button @click="sort('-')" class="filter__sort filter__sort--descending"></button>
      </div>
  </th>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'table-header',

    props: {
      filter: {
        required: true,
        type: Object
      }
    },

    computed: {  
      // only show the sort buttons if the title has a filter
      hasOptions () {
        return this.filter.options != undefined || this.filter.name != undefined
      }
    },

    methods: {
      sort (direction) {
        const sortDirection = direction + this.filter.name
        
        // do not re sort if the order is already correct otherwise the results that
        // have the same value can change places and it looks like the controls aren't working
        if(this.$store.state.sortDirection !== sortDirection){
          this.$store.commit('updateSortDirection', sortDirection)
          eventHub.$emit('sort')
        }
      }
    }
  }
</script>