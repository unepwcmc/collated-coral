<template>
  <span 
    v-show="!isSelected" 
    @click="selectOption({ name: name, option: option })"
    class="filter__select-option">
    {{ option }}
  </span>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'data-filter-option',

    props: {
      name: {
        required: true,
        type: String
      },
      option: {
        required: true
      }
    },

    data () {
      return {
        isSelected: false
      }
    },

    methods: {
      selectOption (option) {
        this.$store.commit('addFilterOption', option)

        this.isSelected = true

        eventHub.$emit('selectOption')
        eventHub.$emit('filtersChanged')
      }
    }
  }
</script>
