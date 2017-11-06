<template>
  <tr v-show="item.isActive">
    <td>{{ item.number }}</td>
    <td><button @click="openModal()">{{ item.project_title }}</button></td>
    <td>{{ item.donor }}</td>
    <td>{{ item.status }}</td>
    <td>{{ item.start_date }}</td>
    <td>{{ item.end_date }}</td>
    <td>{{ item.country }}</td>
    <td>{{ item.ocean_based_region }}</td>
    <td>{{ item.total_project_cost }}</td>
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
