dom = React.DOM

@LinkedinLogin = React.createClass
  displayName: 'LinkedinLogin'
  componentDidMount: ->
    liRoot = document.createElement('div')
    liRoot.id = 'linkedin-root'
    document.body.appendChild liRoot
    ((d, s, id) ->
      element = d.getElementsByTagName(s)[0]
      ljs = element
      js = element
      if d.getElementById(id)
        return
      js = d.createElement(s)
      js.id = id
      js.src = '//platform.linkedin.com/in.js'
      js.text = 'api_key: 77p189z62mcpaa \n authorize: true'
      ljs.parentNode.insertBefore js, ljs
      return
    ) document, 'script', 'linkedin-sdk'
    return
  callbackFunction: ->
    IN.API.Raw('/people/~:(id,firstName,lastName,emailAddress)?format=json').result (data) ->
      console.log data
      $.ajax
          url: '/auth/linkedin',
          type: 'POST', 
          data: IN.ENV.auth,
          success: (res) =>
            console.log res
          error: (e) =>
            console.log e.responseJSON
    return
  handleClick: (e) ->
    e.preventDefault()
    IN.User.authorize @callbackFunction, ''
    return
  render: ->
    dom.div
      className: '',
      dom.button
        onClick: this.handleClick,
        className: 'button social'
        "Continue with Linkedin"
        # className: { "button social " + this.props.name.toLowerCase() + " " + this.props.visibility } > { this.props.text } < i className = { "fi-social-" + this.props.name.toLowerCase() }
