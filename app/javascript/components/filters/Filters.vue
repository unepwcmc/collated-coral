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
  import DataFilter from './DataFilter.vue'

  export default {
    name: "filters",

    components: { DataFilter },

    props: {
      filters: {
        required: true,
        type: Array
      }
    }
  }
</script>