import React from 'react';
import { Route, IndexRoute } from 'react-router';
import { App } from '../containers';
import { requireAuthentication } from '../components/AuthenticatedComponent';

import { LoginSasensei } from '../components/sasensei/login/loginSasensei.js.coffee'
import { HomeSasensei } from '../components/sasensei/home/homeSasensei.js.coffee';

import { RunCardFilterPage } from '../components/sasensei/cards/runCardFilter.js.coffee';
import { RunSessionFilterPage } from '../components/sasensei/sessions/runSessionFilterPage.js.coffee';


/*
  Define all routes required in SPA here
  components available to authenticated users must use requireAuthentication method
*/
export default(
  <Route path='/' component={App}>
    <IndexRoute component={HomeSasensei}/>

    <Route path="login" component={LoginSasensei}/>
    <Route path="react" component={requireAuthentication(HomeSasensei)}/>

    <Route path="cards_run_filter" component={requireAuthentication(RunCardFilterPage)}/>
    <Route path="sessions" component={requireAuthentication(RunSessionFilterPage)}/>
    <Route path="questions">
      <Route path="new"/>
    </Route>
  </Route>
);
