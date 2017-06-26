import React from "react"

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

@GoogleLogin = React.createClass
  displayName: 'GoogleLogin'

  componentDidMount: ->
    ((d, s, id) ->
      element = d.getElementsByTagName(s)[0]
      ljs = element
      js = element
      if d.getElementById(id)
        return
      js = d.createElement(s)
      js.id = id
      js.src = 'https://apis.google.com/js/platform.js'
      js.async
      js.defer
      ljs.parentNode.insertBefore js, ljs
      return
    ) document, 'script', 'google-sdk'
    return

  render: ->
    dom.div
      className: '',
      dom.div
        className: 'g-signin2',
        'data-onsuccess': 'onGSignIn'

export default @GoogleLogin
