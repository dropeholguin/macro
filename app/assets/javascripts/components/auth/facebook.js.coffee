dom = React.DOM

@FacebookLogin = React.createClass
  displayName: 'FacebookLogin'
  componentDidMount: ->
    window.fbAsyncInit = (->
      FB.init
        appId: '104324696849506'
        xfbml: true
        version: 'v2.9'
      # Now that we've initialized the JavaScript SDK, we call
      # FB.getLoginStatus().  This function gets the state of the
      # person visiting this page and can return one of three states to
      # the callback you provide.  They can be:
      #
      # 1. Logged into your app ('connected')
      # 2. Logged into Facebook, but not your app ('not_authorized')
      # 3. Not logged into Facebook and can't tell if they are logged into
      #    your app or not.
      #
      # These three cases are handled in the callback function.
      FB.getLoginStatus ((response) ->
        @statusChangeCallback response
        return
      ).bind(this)
      return
    ).bind(this)
    # Load the SDK asynchronously
    ((d, s, id) ->
      js = undefined
      fjs = d.getElementsByTagName(s)[0]
      if d.getElementById(id)
        return
      js = d.createElement(s)
      js.id = id
      js.src = '//connect.facebook.net/en_US/sdk.js'
      fjs.parentNode.insertBefore js, fjs
      return
    ) document, 'script', 'facebook-jssdk'
    return

  # Here we run a very simple test of the Graph API after login is
  # successful.  See statusChangeCallback() for when this call is made.
  fetchUserInfo: ->
    # maybe don't need this method
    console.log 'Welcome!  Fetching your information.... '
    FB.api '/me', (response) ->
      console.log 'Successful login for: ' + response.name
      # alert('Thanks for logging in, ' + response.name + '!')
      return
    return

  # This is called with the results from from FB.getLoginStatus().

  statusChangeCallback: (response) ->
    # console.log 'statusChangeCallback'
    # console.log response
    # The response object is returned with a status field that lets the
    # app know the current login status of the person.
    # Full docs on the response object can be found in the documentation
    # for FB.getLoginStatus().
    if response.status == 'connected'
      # Logged into your app and Facebook.
      # @fetchUserInfo()
      # POST request to server login
      $.ajax
          url: '/auth/facebook', 
          type: 'POST', 
          data: response.authResponse,
          success: (data) =>
            console.log data

    else if response.status == 'not_authorized'
      # The person is logged into Facebook, but not your app.
      # alert('Please log ' + 'into this app.')
    else
      # The person is not logged into Facebook, so we're not sure if
      # they are logged into this app or not.
      # alert('Please log ' + 'into Facebook.')
    return

  # This function is called when someone finishes with the Login
  # Button.  See the onlogin handler attached to it in the sample
  # code below.

  checkLoginState: ->
    FB.getLoginStatus ((response) ->
      @statusChangeCallback response
      return
    ).bind(this)
    return

  handleClick: ->
    FB.login @checkLoginState()
    return

  render: ->
    dom.div
      className: "row",
      # dangerouslySetInnerHTML: {__html: '<fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>' }
        dom.div
          className: "#{@props.small} #{@props.medium} #{@props.large} small-centered medium-centered large-centered columns text-center",
          dom.div
            className: "fb-login-button margin-20",
            'data-max-rows': "1",
            'data-size': "large",
            'data-button-type': "continue_with",
            'data-show-faces': "false",
            'data-auto-logout-link': "true",
            'data-use-continue-as': "true",
            'data-scope': "public_profile,email",
