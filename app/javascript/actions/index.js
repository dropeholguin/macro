import { checkHttpStatus, parseJSON } from '../utils';
import { pushState } from 'redux-router';
import * as CONSTANTS from '../constants/index.js'

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

export function receiveCardsData(data) {
  return {
    type: CONSTANTS.RECEIVE_CARDS_DATA,
    payload: {
      data: data
    }
  }
}

export function fetchCardsRequest() {
  return {
    type: CONSTANTS.FETCH_CARDS_REQUEST
  }
}

export function getCards() {
  return (dispatch, state) => {
    let userToken = state().auth.current_user.authentication_token;
    let userEmail = state().auth.current_user.email;
    console.log(state().auth)
    dispatch(fetchCardsRequest());
    return fetch(CONSTANTS.BASE_URL + 'cards', {
        credentials: 'include',
        headers: {
          'X-User-Email': userEmail,
          'X-User-Token': userToken
        }
      })
      .then(checkHttpStatus)
      .then(parseJSON)
      .then(response => {
        dispatch(receiveCardsData(response.data));
      })
      .catch(error => {
        if(error.response.status === 401) {
          dispatch(loginUserFailure(error));
          dispatch(pushState(null, '/login'));
        }
      })
    }
}
