import React from 'react';
import ReactDOM from 'react-dom';
import Root from '../containers/Root';
import configureStore from '../store/configureStore';
import {loginUserSuccess} from '../actions';

const target = document.getElementById('app-root');
const store = configureStore(window.__INITIAL_STATE__);

const node = (
    <Root store={store} />
);

let current_user = JSON.parse(localStorage.getItem('current_user'));
if (current_user !== null) {
  store.dispatch(loginUserSuccess(current_user));
}

ReactDOM.render(node, target);
