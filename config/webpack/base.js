const { webpackConfig, merge } = require('@rails/webpacker')

// https://github.com/rails/webpacker/issues/2844
webpackConfig.module.rules.map(module => {
  if (module.test && module.test.toString().includes('scss')) {
    module.use.splice(-1, 0, {
      loader: require.resolve('resolve-url-loader')
    })
  }
  return module
})

const customConfig = {
  resolve: {
    alias: {
      $: 'jquery/src/jquery',
      jQuery: 'jquery/src/jquery'
    },
    extensions: ['.css', '.scss']
  }
}

const jquery = require('./loaders/jquery')
const webpack = require('webpack')

webpackConfig.plugins.unshift(
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery'
  })
)

module.exports = merge(webpackConfig, customConfig, jquery)
