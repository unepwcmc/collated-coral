<template>
  <div class="selected__option">
    
    <p class="selected__text">
      <span v-if="showName" class="selected__filter">{{ filterName }}: </span>{{ option }}
    </p>

    <button @click="deselectOption()" class="selected__close fa fa-times"></button>
  </div>
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

    computed: {
      filterName () {
        const length = this.name.length
        return this.name.substring(0, length - 5)
      },

      showName () {
        return this.name.substr(-4) === 'date'
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