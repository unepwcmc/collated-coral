<template>
  <th>
    <span class="table__header">{{ filter.title }}</span>

    <div v-if="hasOptions" class="table__sorting">
      <span @click="sort('+')" alt="Sort results ascending" class="table__sort table__sort--ascending"></span>
      <span @click="sort('-')" alt="Sort results descending" class="table__sort table__sort--descending"></span>
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