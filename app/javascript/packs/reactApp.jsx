import React from 'react'
import { render } from 'react-dom'
import { sessionService, sessionReducer } from 'redux-react-session';

import App from '../app'
import store from '../store'
import history from '../utils/history'

// Init the session service
sessionService.initSessionService(store);

render(
  <App store={store} history={history} />,
  document.getElementById('app-root')
)
