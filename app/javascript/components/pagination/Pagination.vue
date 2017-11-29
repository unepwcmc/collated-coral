<template>
  <div class="right">
    <div v-if="haveResults">
      <span class="bold">{{ firstItem }} - {{ lastItem }} of {{ totalItems }}</span>

      <button 
        v-bind="{ 'disabled' : !previousIsActive }"
        @click="changePage(previousIsActive, 'previous')"
        class="button button--previous"
        :class="{ 'button--disabled' : !previousIsActive }">
      </button>

      <button 
        v-bind="{ 'disabled' : !nextIsActive }"
        @click="changePage(nextIsActive, 'next')"
        class="button button--next"
        :class="{ 'button--disabled' : !nextIsActive }">
      </button>
    </div>

    <div v-else>
      <p>There are no projects matching the selected filters options.</p>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: "pagination",

    props: {
      itemsPerPage: Number
    },

    data () {
      return {
        totalItems: this.$store.state.totalItems,
        previousIsActive: false,
        nextIsActive: false
      }
    },

    mounted () {
      this.updateButtons()

      eventHub.$on('activeItemsChanged', this.updateButtons)
    },

    computed: {
      firstItem () {
        return this.lastItem - this.itemsPerPage + 1
      },

      lastItem () {
        let lastItem = this.itemsPerPage * this.currentPage
        
        if (lastItem > this.totalItems) {
          lastItem = this.totalItems
        }

        return lastItem
      },

      currentPage () {
        return this.$store.state.currentPage
      },

      totalPages () {
        return Math.ceil(this.totalItems / this.itemsPerPage)
      },

      haveResults () {
        return this.totalItems > 0
      }
    },

    methods: {
      updateButtons () {
        this.totalItems = this.$store.state.totalItems
        this.nextIsActive = this.currentPage < this.totalPages
        this.previousIsActive = this.currentPage > 1

        eventHub.$emit('pageChanged')
      },

      changePage (isActive, direction) {
        // only change the page if the button is active
        if (isActive) {
          const newPage = direction == 'next' ? this.currentPage + 1 : this.currentPage - 1
          
          this.$store.commit('updateCurrentPage', newPage)
          this.updateButtons()
        }
      }
    }
  }
</script>