import React from 'react';
import { Link } from 'react-router';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import * as actionCreators from '../actions';
import HeaderDesktop from '../components/sasensei/header/headerDesktop.js.coffee';

// import '../styles/core.scss';

export class CoreLayout extends React.Component {

  render () {

    const {dispatch} = this.props;

    return (
      <div>
        {this.props.isAuthenticated &&
          <HeaderDesktop />
        }
        {this.props.children}
      </div>
    );
  }
}

const mapStateToProps = state => {
  return {
    isAuthenticated: state.auth.isAuthenticated
  }
};

const mapDispatchToProps = dispatch => {
  return {
    actions : bindActionCreators(actionCreators, dispatch)
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(CoreLayout);


// <div>
//   <nav className="navbar navbar-default">
//     <div className="container">
//       <div className="navbar-header">
//         <Link className="navbar-brand" to="/">React Redux JWT Auth Example</Link>
//       </div>
//       <div id="navbar">
//         <ul className="nav navbar-nav navbar-right">
//           <li><Link to="/protected">Protected Content</Link></li>
//           <li><Link to="/login">Login</Link></li>
//           {this.props.isAuthenticated
//            ? <li><a href='#' onClick={() => this.props.actions.logoutAndRedirect()}>Logout</a> </li>
//            : ''
//           }
//         </ul>
//       </div>
//     </div>
//   </nav>
//   <div className='container'>
//     <div className='row'>
//       <div className='col-xs-12'>
//         {this.props.children}
//       </div>
//     </div>
//   </div>
// </div>