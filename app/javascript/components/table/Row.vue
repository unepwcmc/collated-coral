<template>
  <tr @click="openModal()" v-show="item.isActive">
    <td>{{ item.id }}</td>
    <td :title="item.project_title">{{ projectTitle }}</td>
    <td>{{ item.donors }}</td>
    <td>{{ item.status }}</td>
    <td>{{ item.category }}</td>
    <td>{{ item.ecosystem }}</td>
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

    computed: {
      projectTitle () {
        let title = ''
        const length = this.item.project_title.length

        if (length <= 30) {
          title = this.item.project_title
        } else {
          title = this.item.project_title.substring(0,27) + '...'
        }

        return title
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
