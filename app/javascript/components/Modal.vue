<template>
  <div class="modal-wrapper" :class="{ 'modal--active' : isActive }">
    <div id="modal" :style="styleObject" class="modal">
      <div class="modal__content">
        <button class="modal__close" @click="closeModal()">X</button>

        <p><strong>ID</strong> {{ modalContent.id }}</p>
        <p><strong>Project Title</strong> {{ modalContent.projectTitle }}</p>
        <p><strong>Donor name</strong> {{ modalContent.donor }}</p>
        <p><strong>Status</strong> {{ modalContent.status }}</p>
        <p><strong>Start Date</strong> {{ modalContent.startDate }}</p>
        <p><strong>End Date</strong> {{ modalContent.endDate }}</p>
        <p><strong>Country</strong> {{ modalContent.country }}</p>
        <p><strong>Ocean Based Region</strong> {{ modalContent.oceanBasedRegion }}</p>
        <p><strong>Beneficiaries</strong> {{ modalContent.beneficiaries }}</p>
        <p><strong>Implementing Agency</strong> {{ modalContent.implementingAgency }}</p>
        <p><strong>Total Project Cost</strong> {{ modalContent.totalProjectCost }}</p>
        <p><strong>Co-funding Entities</strong> {{ modalContent.coFundingEntities }}</p>
        <p><strong>Category</strong> {{ modalContent.category }}</p>
        <p><strong>Team Leader</strong> {{ modalContent.teamLeader }}</p>
        <p><strong>Further Information</strong> {{ modalContent.furtherInformation }}</p>
      </div>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../home.js'

  export default {
    name: 'modal',

    data () {
      return {
        isActive: false,
        modalOffset: 0,
        styleObject: {
          top: 0
        },
        modalContent: this.$store.state.modalContent
      }
    },

    mounted () {
      eventHub.$on('openModal', this.openModal)
    },

    methods: {
      openModal () {
        this.modalContent = this.$store.state.modalContent

        // delay calculating the modal height so that the data can update which will increase the height of the modal
        window.setTimeout(() => {
          // calculate modal offset
          var modalHeight = document.getElementById('modal').clientHeight
          var windowHeight = window.innerHeight

          // if the modal is smaller than the screen it is being viewed on
          // then vertically centre it on the screen
          if (modalHeight < windowHeight) {
            var modalOffset = (windowHeight - modalHeight) / 2

            this.modalOffset = window.pageYOffset + modalOffset
          } else {
            this.modalOffset = window.pageYOffset
          }
          
          this.styleObject.top = this.modalOffset + 'px'

          this.isActive = !this.isActive
        }, 100)
      },

      closeModal () {
        this.isActive = !this.isActive
      }
    }
  }
</script>