<template>
  <li class="filter__option">
    <!-- @click="selectOption({ name: name, option: option, type: type })" -->
    <input type="checkbox" :id="optionId" v-model="isSelected" class="filter__checkbox">
    <label :for="optionId" class="filter__checkbox-label">{{ option }}</label>
  </li>
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
      },
      type: {
        type: String
      }
    },

    data () {
      return {
        isSelected: false
      }
    },

    computed : {
      optionId () {
        return this.option.replace(' |(|)|_', '-').toLowerCase()
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
