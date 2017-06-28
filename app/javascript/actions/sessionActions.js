import { sessionService } from 'redux-react-session';
import * as sessionApi from '../api/sessionApi';

import history from '../utils/history'

import store from '../store'

export const login = (user, history2) => {
  return () => {
    return sessionApi.login(user).then(response => {
      const { token } = response;
      sessionService.saveSession({ token })
      .then(() => {
        sessionService.saveUser(response.data)
        .then(() => {

          // store.dispatch({ type: 'TEST_ACTION', value: 20 })
          history.push('/home');
        }).catch(err => console.error(err));
      }).catch(err => console.error(err));
    });
  };
};

export const logout = (history) => {
  return () => {
    return sessionApi.logout().then(() => {
      sessionService.deleteSession();
      sessionService.deleteUser();
      history.push('/login');
    }).catch(err => {
      throw (err);
    });
  };
};
