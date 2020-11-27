const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const { CleanWebpackPlugin } = require('clean-webpack-plugin')

const TITLE = 'elm-bulma examples'
const PORT = process.env.PORT || 3000
const DEST = path.resolve(__dirname, 'dist')

module.exports = {
  mode: 'development',
  entry: path.resolve(__dirname, 'index.js'),
  output: {
    path: DEST,
    filename: '[name].js',
    publicPath: ''
  },
  resolve: {
    modules: [path.resolve(__dirname, './src'), 'node_modules'],
    extensions: ['.elm', '.js', '.json']
  },
  module: {
    rules: [
      {
        test: /\.(woff|woff2|eot|ttf|otf|svg)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]',
          outputPath: 'fonts/'
        }
      },
      {
        test: /\.(ts|js)x?$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.s[ac]ss$/i,
        use: ['style-loader', 'css-loader', 'sass-loader']
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: 'elm-webpack-loader',
          options: {
            debug: true,
            forceWatch: true
          }
        }
      }
    ]
  },
  devtool: 'source-map',
  devServer: {
    disableHostCheck: true,
    historyApiFallback: true,
    host: '0.0.0.0',
    port: PORT,
    hot: true,
    contentBase: ['assets'].map(x => path.resolve(__dirname, x)),
    publicPath: '/',
    watchOptions: {
      ignored: path.resolve(__dirname, 'node_modules')
    }
  },
  optimization: {
    splitChunks: {
      chunks: 'all'
    }
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: TITLE,
      showErrors: true,
      template: path.resolve(__dirname, 'index.ejs')
    }),
    new CleanWebpackPlugin({
      root: __dirname,
      exclude: [],
      verbose: true,
      dry: false
    })
  ]
}
