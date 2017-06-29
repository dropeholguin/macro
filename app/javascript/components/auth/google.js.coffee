import React from 'react';

window.onGSignIn = (googleUser) ->
  $.ajax
      url: '/auth/google',
      type: 'POST',
      data: { auth_token: googleUser.getAuthResponse().id_token },
      success: (data) =>
        console.log data
      error: (e) =>
        console.log e.responseJSON

dom = React.DOM

export default React.createClass
  displayName: 'GoogleLogin'

  customButton: ->
    gapi.load 'auth2', ->
      auth2 = gapi.auth2.init({
        client_id: '566475606812-jjubafu8j3sn5hibe0loo8r4176s0j2n.apps.googleusercontent.com',
        cookiepolicy: 'single_host_origin'})
      
      auth2.attachClickHandler document.getElementById('gCustomBtn'), {}, ((googleUser) ->
        window.onGSignIn googleUser
        return
      ), (error) ->
        alert JSON.stringify(error, undefined, 2)
        return
      return
    return

  componentDidMount: ->
    tempScope = this
    ((d, s, id, tempScope2) ->
      element = d.getElementsByTagName(s)[0]
      ljs = element
      js = element
      if d.getElementById(id)
        return
      js = d.createElement(s)
      js.id = id
      js.src = 'https://apis.google.com/js/api:client.js'
      js.onload = () ->
        tempScope2.customButton()
      js.async
      js.defer
      ljs.parentNode.insertBefore js, ljs
      
      return
    ) document, 'script', 'google-sdk', tempScope
    return

  render: ->
    dom.div
      className: 'button btn-social large btn-block google-plus',
      id: 'gCustomBtn'
      dom.i
        className: "fa fa-google-plus"
      dom.span
        style: {color: "#fff"}
        "Sign in With Google+"
