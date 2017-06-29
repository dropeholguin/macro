import { checkHttpStatus, parseJSON } from '../utils';
import { pushState } from 'redux-router';
import * as CONSTANTS from '../constants'

export function loginUserSuccess(current_user) {
  localStorage.setItem('current_user', JSON.stringify(current_user));
  return {
    type: CONSTANTS.LOGIN_USER_SUCCESS,
    payload: {
      current_user: current_user
    }
  }
}

export function loginUserFailure(error) {
  localStorage.removeItem('current_user');
  return {
    type: CONSTANTS.LOGIN_USER_FAILURE,
    payload: {
      status: error.response.status,
      statusText: error.response.statusText
    }
  }
}

export function loginUserRequest() {
  return {
    type: CONSTANTS.LOGIN_USER_REQUEST
  }
}

export function logout() {
  localStorage.removeItem('current_user');
  return {
    type: CONSTANTS.LOGOUT_USER
  }
}

export function logoutAndRedirect() {
  return (dispatch, state) => {
    dispatch(logout());
    dispatch(pushState(null, '/login'));
  }
}

export function authLogin(provider, auth_token, redirect='/'){
  return function(dispatch) {
    dispatch(loginUserRequest());
    return fetch((CONSTANTS.BASE_URL + CONSTANTS.PROVIDER_URL[provider]), {
        method: 'post',
        // credentials: 'include',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ auth_token: auth_token })
      })
      .then(checkHttpStatus)
      .then(parseJSON)
      .then(response => {
        try {
          if(response.success){
            dispatch(loginUserSuccess(response.user));
            dispatch(pushState(null, redirect));
          }
          else{
            dispatch(loginUserFailure({
              response: {
                status: 403,
                statusText: 'Auth failure'
              }
            }));
          }
        } catch (e) {
          dispatch(loginUserFailure({
            response: {
              status: 403,
              statusText: 'Invalid response'
            }
          }));
        }
      })
      .catch(error => {
        dispatch(loginUserFailure(error));
      })
  }
}

export function loginUser(email, password, redirect="/") {
  return function(dispatch) {
    dispatch(loginUserRequest());
    return fetch('http://localhost:3000/auth/getToken/', {
      method: 'post',
      credentials: 'include',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
        body: JSON.stringify({email: email, password: password})
      })
      .then(checkHttpStatus)
      .then(parseJSON)
      .then(response => {
        try {
          dispatch(loginUserSuccess(response.token));
          dispatch(pushState(null, redirect));
        } catch (e) {
          dispatch(loginUserFailure({
            response: {
              status: 403,
              statusText: 'Invalid token'
            }
          }));
        }
      })
      .catch(error => {
        dispatch(loginUserFailure(error));
      })
  }
}

export function receiveProtectedData(data) {
  return {
    type: CONSTANTS.RECEIVE_PROTECTED_DATA,
    payload: {
      data: data
    }
  }
}

export function fetchProtectedDataRequest() {
  return {
    type: CONSTANTS.FETCH_PROTECTED_DATA_REQUEST
  }
}

export function fetchProtectedData(token) {
  return (dispatch, state) => {
    dispatch(fetchProtectedDataRequest());
    return fetch('http://localhost:3000/api/v1/cards_index', {
        credentials: 'include',
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })
      .then(checkHttpStatus)
      .then(parseJSON)
      .then(response => {
        dispatch(receiveProtectedData(response.data));
      })
      .catch(error => {
        if(error.response.status === 401) {
          dispatch(loginUserFailure(error));
          dispatch(pushState(null, '/login'));
        }
      })
    }
}
