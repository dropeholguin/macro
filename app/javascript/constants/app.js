import React, { Component } from 'react';
import { combineReducers } from 'redux';
import { Provider } from 'react-redux';

// import { createStore, renderDevTools } from '../utils/devTools';

// import FriendListApp from './FriendListApp';
import * as reducers from '../reducers';

const reducer = combineReducers(reducers);
const store = createStore(reducer);
