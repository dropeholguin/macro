import React from 'react'
import ReactDOM from 'react-dom'
// import PropTypes from 'prop-types'
import Home from '../components/home/index.js.coffee'
import ImgPath from '../components/helpers/image_helper'


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Home arrow_img={ ImgPath('arrow.png', true)} card_img={ ImgPath('cards.png') }
    session_img={ ImgPath('session.png') } submit_img={ ImgPath('submit.png') } stock_img={ ImgPath('stock-2bg.jpg') }
    img={ ImgPath('logo-macro.png') } />, document.getElementById('app-root'));
})
