dom = React.DOM 


@SignUp = React.createClass
	displayName: 'SignUp'
	getDefaultProps: ->
		url: '/users',
		large: "large-5"
		medium: "medium-6"
		small: "small-9"
	render: ->
		dom.div
			className: "root",
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
							className: "title",
							dom.h3 {},
								"SIGN UP"							
						dom.a
							className: "button expanded btn-linkedin linkedin-color radius-40",
							dom.i
								className: "fa fa-linkedin-square fa-2x",
								'aria-hidden': "true",
							dom.span 
								className: "fntsize-25",
								" Sign Up with LinkedIn ",	
						dom.div
							className: "divider",
							dom.strong
								className: "divider-title",
								"Or",									
						dom.input
							className: "radius-10",
							type:  "text",
							name: "user[name]",
							key:"name",
							id: "name",
							placeholder: "Your name",
						dom.input
							className: "radius-10",
							type:  "text",
							name: "user[email]",
							key: "email",
							id: "email",
							placeholder: "Your email",
						dom.input
							className: "radius-10",
							autofocus: "off",
							type:  "password",
							name: 'user[password]',
							key: "password",
							id: "password",
							placeholder: "Your password (6 characters minimum)",
						dom.input
							className: "radius-10",
							autofocus: "off",
							type:  "password",
							name: 'user[password_confirmation]',
							key: "password_confirmation",
							id: "password_confirmation",
							placeholder: "Confirm your password",
						dom.input
							className: "button expanded primary radius-40 white",
							value: "SIGN UP",
							type: 'submit',
						dom.p {},
							"Already have an account?",
						dom.p {},
							@props.devise_error_messages
						dom.a
							href: "/users/sign_in", 
							className: "bold",
							"SIGNON"
			


