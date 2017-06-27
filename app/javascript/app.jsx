import React from 'react'
import { Provider } from 'react-redux'
import { BrowserRouter, Route } from 'react-router-dom'

import Home from './components/home/index.js.coffee'
import SignIn from './components/signIn.js.coffee'
import SignUp from './components/signUp.js.coffee'

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
        <BrowserRouter>
          <div>
            <Route path="/react" component={Home}/>
            <Route path="/sign_in" component={SignIn}/>
            <Route path="/sign_up" component={SignUp}/>
          </div>
        </BrowserRouter>
      </Provider>
    )
  }
}
