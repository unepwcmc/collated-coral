<template>
  <div class="modal-wrapper" :class="{ 'modal--active' : isActive }" @click.self="closeModal()">
    <div id="modal" :style="styleObject" class="modal">
      <div class="modal__content">
        <button class="modal__close fa fa-times button button--blue" @click="closeModal()"></button>

        <h2>Project Details</h2>

        <p><strong>ID:</strong> {{ modalContent.id }}</p>
        <p><strong>Project Title:</strong> {{ modalContent.project_title }}</p>
        <p><strong>Donor name:</strong> {{ printMultiple('donors') }}</p>
        <p><strong>Status:</strong> {{ modalContent.status }}</p>
        <p><strong>Start Date:</strong> {{ modalContent.start_date }}</p>
        <p><strong>End Date:</strong> {{ modalContent.end_date }}</p>
        <p><strong>Country:</strong> {{ printMultiple('country') }}</p>
        <p><strong>Ocean Based Region:</strong> {{ printMultiple('ocean_based_region') }}</p>
        <p><strong>Ecosystem:</strong> {{ printMultiple('ecosystem') }}</p>
        <p><strong>Beneficiaries:</strong> {{ modalContent.beneficiaries }}</p>
        <p><strong>Implementing Agency:</strong> {{ modalContent.implementing_agency }}</p>
        <p><strong>Total Project Cost:</strong> {{ modalContent.total_project_cost }}</p>
        <p><strong>Primary Funding:</strong> {{ modalContent.primay_funding }}</p>
        <p><strong>Co-funding:</strong> {{ modalContent.co_funding_entities }}</p>
        <p><strong>Category:</strong> {{ modalContent.category }}</p>
        <p><strong>Further Information:</strong> {{ modalContent.further_information }}</p>
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
      },

      printMultiple (field) {
        // print out the array of values comma separated as a string
        let array = this.modalContent[field]

        if (array !== undefined) {
          return array.join(', ')
        }
      }
    }
  }
</script>
