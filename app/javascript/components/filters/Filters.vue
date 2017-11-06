<template>
  <tr>
    <data-filter v-for="filter in filters"
      :name="filter.name"
      :title="filter.title" 
      :options="filter.options">
    </data-filter>
  </tr>
</template>

<script>
  import { eventHub } from "../../home.js";
  import DataFilter from './DataFilter.vue'

  export default {
    name: "filters",

    components: { DataFilter },

    props: {
      filters: {
        required: true,
        type: Array
      }
    },

    data () {
      return  {
        children: this.$children
      }
    },

    mounted () {
      eventHub.$on('clickDropdown', this.updateDropdowns)
    },

    methods: {
      updateDropdowns (name) {
        this.children.forEach(filter => {
          filter.isOpen = filter.name == name
        })
      }
    }
  }
</script>