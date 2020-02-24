<template>
  <form action="/download" method="post">
      <input name="ids" type="hidden" v-bind:value="postIds"></input>
      <input 
        type="submit" 
        value="CSV" 
        title="Download CSV file of filtered Coral projects" 
        class="button button--download button--accent-2 filter__download"
        :class="{ 'button--disabled' : !hasResults }"
        v-bind="{ 'disabled' : !hasResults }">
      </input>
    </form>
</template>

<script>
  export default {
    name: 'download-csv',

    computed: {
      postIds () {
        return this.$store.state.activeItems
      },
      
      hasResults () {
        return this.$store.state.activeItems.length > 0
      }
    }
  }
</script>