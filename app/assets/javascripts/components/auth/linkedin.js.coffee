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
      js.text = 'api_key: [YOUR_API_KEY]'
      ljs.parentNode.insertBefore js, ljs
      return
    ) document, 'script', 'linkedin-sdk'
    return
  callbackFunction: ->
    IN.API.Profile('me').result (r) ->
      console.log r
      return
    return
  handleClick: (e) ->
    e.preventDefault()
    IN.User.authorize @callbackFunction, ''
    return
  render: ->
    dom.div
      className: "",
      dom.button
        onClick: this.handleClick
        # className: { "button social " + this.props.name.toLowerCase() + " " + this.props.visibility } > { this.props.text } < i className = { "fi-social-" + this.props.name.toLowerCase() }
