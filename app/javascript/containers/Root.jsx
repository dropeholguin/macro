import React from 'react';
import { Provider } from 'react-redux';
import { ReduxRouter } from 'redux-router';
import routes from '../routes';

/*
  Main entry point of our SPA
*/
export default class Root extends React.Component {

  static propTypes = {
    store: React.PropTypes.object.isRequired
  };

  render () {
    return (
      <div>
        <Provider store={this.props.store}>
          <div>
            <ReduxRouter>
              {routes}
            </ReduxRouter>
          </div>
        </Provider>
      </div>
    );
  }
}
