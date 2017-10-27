<template>
  <div>
    <button @click="changePage(previousIsActive, 'previous')">Previous</button>
    Page {{ currentPage }} of {{ totalPages }}
    <button @click="changePage(nextIsActive, 'next')">Next</button>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: "pagination",

    props: {
      itemsPerPage: Number,
      totalItems: Number,
      activeItems: []
    },

    data () {
      return {
        totalPages: Math.ceil(this.totalItems / this.itemsPerPage),
        previousIsActive: false,
        nextIsActive: false
      }
    },

    created () {
      this.$store.commit('updateItemsPerPage', this.itemsPerPage)
    },

    mounted () {
      this.updateButtons()
    },

    computed: {
      currentPage () {
        return this.$store.state.currentPage
      }
    },

    methods: {
      updateButtons () {
        this.nextIsActive = this.currentPage < this.totalPages
        this.previousIsActive = this.currentPage > 1

        eventHub.$emit('pageChanged')
      },

      changePage (isActive, direction) {
        // only change the page if the button is active
        if(isActive) {
          const newPage = direction == 'next' ? this.currentPage + 1 : this.currentPage - 1
          
          this.$store.commit('updateCurrentPage', newPage)
          this.updateButtons()
        }
      }
    }
  }
</script>