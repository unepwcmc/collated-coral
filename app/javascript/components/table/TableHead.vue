<template>
  <thead id="sticky" :class="{ 'table__head--stuck' : isSticky }">
    <tr>
      <table-header v-for="filter in filters" :filter="filter"></table-header>
    </tr>
  </thead>
</template>

<script>
  import TableHeader from './TableHeader.vue'

  export default {
    name: 'table-head',

    components: { TableHeader },

    props: {
      filters: {
        required: true,
        type: Array
      }
    },

    data() {
      return {
        stickyTrigger: 0,
        isSticky: false
      }
    },

    mounted () {
      this.setStickyTrigger()
      this.scrollHandler()
    },

    methods: {
      setStickyTrigger () {
        const stickyElement = document.getElementById('sticky')
        const stickyElementHeight = stickyElement.clientHeight
        const stickyYOffset = stickyElement.getBoundingClientRect().top + window.pageYOffset

        this.stickyTrigger = stickyElementHeight + stickyYOffset
      },

      scrollHandler () {
        setInterval( () => {
          let scrollY = window.pageYOffset

          this.isSticky = scrollY > this.stickyTrigger ? true : false
        }, 100)
      }
    }
  }
</script>