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
      index: Number,
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
        // remove this from the active filter list
        this.$store.commit('removeFilterOption', this.index)
        eventHub.$emit('deselectOption', { name: this.name, option: this.option })
        eventHub.$emit('filtersChanged')
      }
    }
  }
</script>