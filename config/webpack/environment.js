const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const sass_loader = environment.loaders.get('sass')
sass_loader.use.splice(-1, 0, {
  loader: 'resolve-url-loader'
})
sass_loader.use.push('import-glob-loader')
environment.loaders.prepend('erb', erb)

const webpack = require('webpack')
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
    Cookies: 'js-cookie',
    emojione: 'emojione'
  })
)

environment.splitChunks()
module.exports = environment
