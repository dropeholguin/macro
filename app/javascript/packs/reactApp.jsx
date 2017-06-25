import React from 'react'
import { render } from 'react-dom'
import { createStore } from 'redux'

import App from '../app'
import reducers from '../reducers'

const store = createStore(
  reducers,
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
);

render(
  <App store={store} />,
  document.getElementById('app-root')
)
