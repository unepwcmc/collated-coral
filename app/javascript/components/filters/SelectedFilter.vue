<template>
  <p>
    {{ option }}
    <button @click="deselectOption()">x</button>
  </p>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'selected-filter',

    props: {
      name: {
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
        // remove this option from the active filter list and update results
        this.$store.commit('removeFilterOption', { name: this.name, option: this.option })
        eventHub.$emit('deselectOption', { name: this.name, option: this.option })
        eventHub.$emit('filtersChanged')
      }
    }
  }
</script>