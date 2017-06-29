import {createReducer} from '../utils';
import {LOGIN_USER_REQUEST, LOGIN_USER_SUCCESS, LOGIN_USER_FAILURE, LOGOUT_USER} from '../constants';
import {pushState} from 'redux-router';

const initialState = {
  current_user: null,
  token: null,
  isAuthenticated: false,
  isAuthenticating: false,
  statusText: null
};

export default createReducer(initialState, {
  [LOGIN_USER_REQUEST]: (state, payload) => {
    return Object.assign({}, state, {
      'current_user': null,
      'isAuthenticating': true,
      'statusText': null
    });
  },
  [LOGIN_USER_SUCCESS]: (state, payload) => {
    return Object.assign({}, state, {
      'current_user': payload.current_user,
      'isAuthenticating': false,
      'isAuthenticated': true,
      'token': payload.token,
      'statusText': 'You have been successfully logged in.'
    });

  },
  [LOGIN_USER_FAILURE]: (state, payload) => {
    return Object.assign({}, state, {
      'current_user': null,
      'isAuthenticating': false,
      'isAuthenticated': false,
      'token': null,
      'statusText': `Authentication Error: ${payload.status} ${payload.statusText}`
    });
  },
  [LOGOUT_USER]: (state, payload) => {
    return Object.assign({}, state, {
      'current_user': null,
      'isAuthenticated': false,
      'token': null,
      'statusText': 'You have been successfully logged out.'
    });
  }
});
