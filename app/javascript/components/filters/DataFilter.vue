<template>
  <td>
    <span>
      <p>{{ title }}</p>
      <select v-if="hasOptions" multiple>
        <data-filter-option v-for="option in options" 
          :name="name"
          :filter="title" 
          :option="option">
        </data-filter-option>
      </select>
    </span>
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
        children: this.$children
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
      }
    }
  }
</script>