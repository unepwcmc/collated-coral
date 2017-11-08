<template>
  <td>
    <div v-if="hasOptions" class="filter">
      <p @click="openSelect()" class="filter__title" :class="{ 'filter__title--active' : isOpen }">{{ title }}</p>

      <select multiple class="filter__select" :class="{ 'filter__select--active' : isOpen }">
        <data-filter-option v-for="option in options" 
          :name="name"
          :filter="title" 
          :option="option">
        </data-filter-option>
      </select>

      <p>
        <button @click="sort('+')" class="filter__sort filter__sort--ascending"></button>
        <button @click="sort('-')" class="filter__sort filter__sort--descending"></button>
      </p>
    </div>

    <div v-else class="filter">
      <p>{{ title }}</p>
    </div>
  </td>
</template>

<script>
  import { eventHub } from '../../home.js'
  import DataFilterOption from './DataFilterOption.vue'

  export default {
    name: 'data-filter',

    components: { DataFilterOption },

    props: {
      name: {
        type: String
      },
      title: {
        required: true, 
        type: String
      },
      options: {
        type: Array
      }
    },

    data () {
      return {
        children: this.$children,
        isOpen: false
      }
    },

    mounted () {
      eventHub.$on('deselectOption', this.updateFilterOptions)
    },

    computed: {
      // only show the select if the filter is a real filter and not just a table title
      hasOptions () {
        return this.options != undefined || this.name != undefined
      }
    },

    methods: {
      updateFilterOptions (filterOption) {
        // if the filter matches the one that has been deselected 
        // search for the matching option and set isSelected to false
        if(this.name == filterOption.name){
          this.children.forEach(child => {
            if(child.option == filterOption.option) child.isSelected = false
          })
        }
      },

      openSelect () {
        // if the filter is open is close it, else open it and close the others
        if(this.isOpen){
          this.isOpen = false
        } else {
          eventHub.$emit('clickDropdown', this.name)  
        }
      },

      closeSelect () {
        this.isOpen = false
      },

      sort (direction) {
        const sortDirection = direction + this.name
        
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