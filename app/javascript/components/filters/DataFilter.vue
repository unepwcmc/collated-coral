<template>
  <td>
    <span>
      {{ title }}
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
  import DataFilterOption from './DataFilterOption.vue'

  export default {
    name: 'data-filter',

    components: { DataFilterOption},

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
        remainingOptions: this.options,
        isActive: false

      }
    },

    computed: {
      // only show the select if the filter is a real filter and not just a table title
      hasOptions () {
        return this.options != undefined || this.name != undefined
      }
    }
  }
</script>