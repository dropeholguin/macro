import React from 'react'
import { Provider } from 'react-redux'

import { IndexRoute } from 'react-router';
import { Router, Route } from 'react-router-dom'

import { sessionService } from 'redux-react-session';

import Home from './components/home/index.js.coffee'
import SignIn from './components/signIn.js.coffee'
// import SignUp from './components/signUp.js.coffee'

import Login from './components/Login'

// import { renderDevTools } from './utils/devTools';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      store: props.store
    };
  }

  render(){
    return (
      <Provider store={this.props.store}>
        <Router history={this.props.history}>
          <div>
            <Route exact path='/react' component={Login} />
            <Route exact path='/home' onEnter={sessionService.checkAuth} component={Home} />
            <Route exact path="/sign_in" component={SignIn}/>
          </div>
        </Router>
      </Provider>
    )
  }
}

// <Route onEnter={sessionService.checkAuth} path="/react" component={Home}/>
// <Route path="/login" component={SignIn} />
// <Route path="/sign_in" component={SignIn}/>
// <Route path="/sign_up" component={SignUp}/>
