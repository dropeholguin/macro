dom = React.DOM 


@SignUp = React.createClass
	displayName: 'SignUp'
	getDefaultProps: ->
		url: '/users',
		large: "large-5"
		medium: "medium-6"
		small: "small-9"
	componentDidMount: ->
		checked = $('#register').is(':checked')
	termsAgreedClicked: (event) ->
		if 	$('#register').is(':checked')
			console.log ("True")
		else 
			console.log ("False")
	render: ->
		dom.div
			className: "root white-background margin-auto",
			dom.form 
				method: 'POST',
				action: @props.url,	
				dom.input
					key: "utf8"
					name: "utf8"
					type: "hidden"
					value: "✓"
				dom.input({
					key: "authenticity_token"
					name: "authenticity_token"
					type: "hidden"
					value: @props.csrfToken
					});					
				dom.div
					className: "row",
					dom.div
						className: "#{@props.small} #{@props.medium} #{@props.large} small-centered medium-centered large-centered columns text-center",
						dom.div
							className: "fb-login-button margin-20",
							'data-max-rows': "1",
							'data-size': "large",
							'data-button-type': "continue_with",
							'data-show-faces': "false",
							'data-auto-logout-link': "false",
							'data-use-continue-as': "true",
							'data-auto-logout-link': "true",
						dom.a
							className: "button expanded btn-linkedin linkedin-color radius-40",
							href: @props.linkedin,
							dom.i
								className: "fa fa-linkedin-square fa-2x",
								'aria-hidden': "true",
							dom.span 
								className: "fntsize-25",
								" SIGNON with LinkedIn ",	
						dom.div
							className: "divider",
							dom.strong
								className: "divider-title",
								"Or",									
						dom.input
							className: "radius-10",
							type:  "text",
							name: "user[email]",
							key: "email",
							id: "email",
							placeholder: "Your email",
						dom.input
							className: "radius-10",
							autoFocus: "off",
							type:  "password",
							name: 'user[password]',
							key: "password",
							id: "password",
							placeholder: "Your password (6 characters minimum)",
						dom.input
							className: "radius-10",
							autoFocus: "off",
							type:  "password",
							name: 'user[password_confirmation]',
							key: "password_confirmation",
							id: "password_confirmation",
							placeholder: "Confirm your password",
						dom.div 
							className: "large-12 columns text-left"
							dom.p {},	
								dom.input
									onClick: @termsAgreedClicked
									id: "terms"
									ref: "terms"
									type: "checkbox"
								dom.label
									htmlFor: "terms"
									"Do you agree " 
									dom.a 
										href: "/terms" 
										"terms and conditions ?"
						dom.input
							id: "register"
							className: "button expanded primary radius-40 white",
							value: "REGISTER",
							type: 'submit',
						dom.p {},
							"Already have an account?",						
						dom.a
							href: "/users/sign_in", 
							className: "bold",
							"SIGNON"
			


