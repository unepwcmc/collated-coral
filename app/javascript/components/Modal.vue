<template>
  <div class="modal-wrapper" :class="{ 'modal--active' : isActive }" @click.self="closeModal()">
    <div id="modal" :style="styleObject" class="modal">
      <div class="modal__content">
        <button class="modal__close fa fa-times button button--accent" @click="closeModal()"></button>

        <h2>Project Details</h2>

        <p><strong>ID:</strong> {{ modalContent.id }}</p>
        <p><strong>Project Title:</strong> {{ modalContent.title }}</p>
        <p><strong>Donor:</strong> {{ printMultiple('donors') }}</p>
        <p><strong>Status:</strong> {{ modalContent.status }}</p>
        <p><strong>Start Date:</strong> {{ modalContent.start_date }}</p>
        <p><strong>End Date:</strong> {{ modalContent.end_date }}</p>
        <p><strong>Country:</strong> {{ printMultiple('country') }}</p>
        <p><strong>Ocean Based Region:</strong> {{ printMultiple('ocean_based_region') }}</p>
        <p><strong>Ecosystem:</strong> {{ printMultiple('ecosystem') }}</p>

        <template v-if="hasContent(modalContent.beneficiaries)">
          <p><strong>Beneficiaries:</strong> {{ modalContent.beneficiaries }}</p>
        </template>

        <template v-if="hasContent(modalContent.implementing_agency)">
          <p><strong>Implementing Agency:</strong> {{ modalContent.implementing_agency }}</p>
        </template>

        <template v-if="hasContent(modalContent.total_project_cost)">
          <p><strong>Total Project Cost:</strong> USD {{ modalContent.total_project_cost }}</p>
        </template>

        <template v-if="hasContent(modalContent.primary_funding)">
          <p><strong>Primary Funding:</strong> USD {{ modalContent.primary_funding }}</p>
        </template>

        <template v-if="hasContent(modalContent.co_funding_entities)">
          <p><strong>Co-funding:</strong> USD {{ modalContent.co_funding_entities }}</p>
        </template>

        <template v-if="hasContent(modalContent.categories)">
          <p><strong>Category:</strong> {{ printMultiple('categories') }}</p>
        </template>

        <template v-if="hasContent(modalContent.further_information)">
          <p><strong>Further Information:</strong> {{ modalContent.further_information }}</p>
        </template>

        <template v-if="hasContent(modalContent.weblink)">
          <p><strong>Web link:</strong> <a :href="modalContent.weblink" target="_blank" :title="'Visit ' + modalContent.weblink">Link</a></p>
        </template>
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
      },

      hasContent (property) {
        return !!property
      }
    }
  }
</script>
