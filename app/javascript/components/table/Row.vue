<template>
  <tr v-show="item.isActive">
    <td>{{ item.id }}</td>
    <td><button @click="openModal()">{{ item.projectTitle }}</button></td>
    <td>{{ item.donor }}</td>
    <td>{{ item.status }}</td>
    <td>{{ item.startDate }}</td>
    <td>{{ item.endDate }}</td>
    <td>{{ item.country }}</td>
    <td>{{ item.oceanBasedRegion }}</td>
    <td>{{ item.totalProjectCost }}</td>
  </tr>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: "row",
    props: {
      item: {
        required: true,
        type: Object,
      }
    },

    methods: {
      openModal () {
        this.$store.commit('updateModalContent', this.item)

        eventHub.$emit('openModal')
      }
    }
  }
</script>
