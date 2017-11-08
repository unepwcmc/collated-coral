<template>
  <option v-show="!isSelected" @click="selectOption({ name: name, option: option })">{{ option }}</option>
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
        required: true,
        type: String
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