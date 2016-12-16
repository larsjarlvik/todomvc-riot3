const webpack = require('webpack');

module.exports = {
  entry: './scripts/app',
  output: {
    path: __dirname + '/dist',
    filename: 'bundle.js',
    sourceMapFilename: '[file].map'
  },
  plugins: [
    new webpack.ProvidePlugin({ riot: 'riot' })
  ],
  module: {
    loaders: [
      { 
        test: /\.js?$|\.tag$/,
        exclude: /(node_modules)/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      },
      { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs-loader', query: { type: 'none' } }
    ]
  },
  devServer: {
    contentBase: './'
  }
};
