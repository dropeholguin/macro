dom = React.DOM 

@LoginButton = React.createClass
	displayName: 'LoginButton'
	getDefaultProps: ->
		path: "#"
	render: ->
		dom.a
			className: "button btn-social large btn-block #{@props.button.class}"
			href: @props.button.path
			dom.i
				className: "#{@props.button.icon}"
			dom.span
				style: {color: "#fff"}
				"Sign in With #{@props.button.name}" 

