<template>
  <tr v-show="item.isActive">
    <td>{{ item.id }}</td>
    <td>{{ item.projectTitle }}</td>
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
  export default {
    name: "row",
    props: {
      item: {
        required: true,
        type: Object,
      }
    }
  }
</script>
