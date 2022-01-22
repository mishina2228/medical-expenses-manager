const { environment } = require('@rails/webpacker')

const sassLoader = environment.loaders.get('sass')
sassLoader.use.splice(-1, 0, {
  loader: 'resolve-url-loader'
})

const webpack = require('webpack')
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
)

environment.splitChunks()
module.exports = environment
