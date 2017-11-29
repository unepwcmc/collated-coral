<template>
  <div v-if="hasOptions" class="filter">
    <p
      @click="openSelect()" 
      class="filter__button button" 
      :class="{ 'filter__button--active' : isOpen , 'filter__button--has-selected' : hasSelected }">

      {{ title }} <span v-show="hasSelected" class="filter__button-total">{{ totalSelectedOptions }}</span>
    </p>
    
    <div class="filter__options" :class="{ 'filter__options--active' : isOpen }">
      <ul class="ul-unstyled filter__options-list" :class="filterClass">
        <data-filter-option v-for="option in options" 
          :option="option"
          :selected="false">
        </data-filter-option>
      </ul>

      <div class="filter__buttons">
        <button @click="clear()" class="button--link bold float-left">Clear</button>
        <button @click="cancel()" class="button--link">Cancel</button>
        <button @click="apply()" class="button--link button--link--green bold">Apply</button>
      </div>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'
  import DataFilterOption from './DataFilterOption.vue'

  export default {
    name: 'data-filter',

    components: { DataFilterOption },

    props: {
      name: {
        type: String
      },
      title: {
        required: true, 
        type: String
      },
      options: {
        type: Array
      },
      type: {
        type: String
      }
    },

    data () {
      return {
        children: this.$children,
        isOpen: false,
        activeOptions: []
      }
    },

    computed: {
      // only show the select if the filter is a real filter and not just a table title
      hasOptions () {
        return this.options != undefined || this.name != undefined
      },

      selectedOptions () {
        // get () {
          let selectedArray = []

          this.children.forEach(child => {
            if(child.isSelected){ 
              let obj = {}
              obj.name = this.name
              obj.option = child.option
              obj.type = this.type

              selectedArray.push(obj) 
            }
          })

          return selectedArray
        // },
        // set (array) {
        //   array.forEach(activeOption => {
        //     this.children.forEach(child => {
        //       if (child.option === activeOption.option) {
        //         console.log(child.selected)
        //         child.selected = true
        //         console.log(child.selected)
        //       } else {
        //         child.selected = false
        //       }
        //     })
        //   })
        // }
      },

      hasSelected () {
        return this.totalSelectedOptions > 0
      },

      totalSelectedOptions () {
        return this.selectedOptions.length
      },

      filterClass () {
        return 'filter__options--' + this.name.replace('_| |(|)', '-').toLowerCase()
      }
    },

    methods: {
      openSelect () {
        // if the filter is open is close it, else open it and close the others
        if(this.isOpen){
          this.isOpen = false
        } else {
          eventHub.$emit('clickDropdown', this.name)  
        }
      },

      closeSelect () {
        this.isOpen = false
      },

      cancel() {
        this.closeSelect()
        
        //reset selected options to the active ones
        // this.selectedOptions = this.activeOptions
        this.activeOptions.forEach(activeOption => {
          console.log('activeOption', activeOption)
          this.children.forEach(child => {
            if (child.option === activeOption.option) {
              console.log(child.isSelected)
              child.isSelected = true
              console.log('should be true', child.isSelected)
            } else {
              console.log(child.isSelected)
              child.isSelected = false
              console.log('should be false', child.isSelected)
            }
          })
        })
      },

      clear () {
        // set the isSelected property on all options to false
        this.children.forEach(child => {
          child.isSelected = false
        })
      },

      apply () {
        this.closeSelect()

        this.$store.commit('clearFilterOptions')

        //update the active filters array
        this.activeOptions = this.selectedOptions

        this.activeOptions.forEach(option => {
          this.$store.commit('addFilterOption', option)
        })

        eventHub.$emit('filtersChanged')
      }
    }
  }
</script>