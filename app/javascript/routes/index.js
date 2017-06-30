import React from 'react';
import { Route, IndexRoute } from 'react-router';
import { App } from '../containers';
import { HomeView, LoginView, ProtectedView } from '../views';
import { requireAuthentication } from '../components/AuthenticatedComponent';

import { LoginSasensei } from '../components/sasensei/login/loginSasensei.js.coffee'
import { HomeSasensei } from '../components/sasensei/home/homeSasensei.js.coffee';

export default(
    <Route path='/' component={App}>
        <IndexRoute component={HomeSasensei}/>
        <Route path="react" component={requireAuthentication(HomeSasensei)}/>
        <Route path="login" component={LoginSasensei}/>
        <Route path="protected" component={requireAuthentication(ProtectedView)}/>
    </Route>
);
