<template>
  <span @click="deselectOption()">{{ option }}</span>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'selected-filter',

    props: {
      filter: {
        required: true,
        type: String
      },
      option: {
        required: true,
        type: String
      }
    },

    methods: {
      deselectOption () {
        // remove this from the active filter list
        eventHub.$emit('deselectOption', { filter: filter, option: option })

      }
    }
  }
</script>