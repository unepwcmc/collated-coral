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
      filter: {
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
        // console.log('click', option)
        this.$store.commit('addFilterOption', option)

        // console.log('selected Filter options', this.$store.state.selectedFilterOptions)
        // const index = this.remainingOptions.indexOf(option)
        // this.remainingOptions.splice(index, 1)

        this.isSelected = true

        eventHub.$emit('filtersChanged')
      }
    }
  }
</script>