dom = React.DOM 

@LoginSasensei = React.createClass
	displayName: 'Login'
	getDefaultProps: ->
		buttons: [{name: 'LinkedIn', icon: 'fa fa-linkedin', class: 'linkedin', path: '/users/auth/linkedin'},
		{name: 'Google+', icon: 'fa fa-google-plus', class: 'google-plus'},
		{name: 'Facebook', icon: 'fa fa-facebook', class: 'facebook'}]
	render: ->
		dom.div
			className: "root"
			dom.div
				className: "row"
				dom.div
					className: "large-9 large-centered columns"	
					dom.div 
						className: "logo-container margin-top-40"
						dom.a
							href: "/"
							className: "logo"
					dom.div 
						className: "text-center uppercase sasensei-title margin-top-40"
						"Signon Using one of the platforms below"
					dom.div
						className: "button-field row margin-top-40"
						dom.div
							className: "large-4 medium-5 medium-centered small-9 small-centered large-centered columns"
							style: {marginTop: "30px"}	
							for button in @props.buttons
								React.createElement LoginButton, key: button.id, button: button
							

