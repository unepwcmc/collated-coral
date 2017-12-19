const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

module.exports = environment

environment.loaders.append('vue', vue)
