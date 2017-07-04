import React from 'react';
import { connect } from 'react-redux';
import { pushState } from 'redux-router';

/*
  validates if component is accessible to user
*/
export function requireAuthentication(Component) {

  class AuthenticatedComponent extends React.Component {

    componentWillMount () {
      this.checkAuth(this.props.isAuthenticated);
    }

    componentWillReceiveProps (nextProps) {
      this.checkAuth(nextProps.isAuthenticated);
    }

    checkAuth (isAuthenticated) {
      if (!isAuthenticated) {
        let redirectAfterLogin = this.props.location.pathname;
        this.props
          .dispatch(pushState(null, `/login?next=${redirectAfterLogin}`));
      }
    }

    render () {
      return (
        <div>
          {this.props.isAuthenticated === true
            ? <Component {...this.props}/>
            : null
          }
        </div>
      )

    }
  }

  const mapStateToProps = (state) => ({
    current_user: state.auth.current_user,
    isAuthenticated: state.auth.isAuthenticated
  });

  return connect(mapStateToProps)(AuthenticatedComponent);
}
