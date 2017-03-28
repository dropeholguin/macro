dom = React.DOM 


@SignIn = React.createClass
	displayName: 'SignIn'
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
						className: "small-9 medium-6 large-5 small-centered medium-centered large-centered columns text-center",
						dom.div
							className: "title-signin",
							dom.h3 {},
								"WELCOME"																			
						dom.input
							className: "radius-10",
							type:  "text",
							name: "user[email]",
							key: "email",
							id: "user_email"
							placeholder: "Your email",
						dom.input
							className: "radius-10",
							type:  "password",
							name: 'user[password]',
							key: "password",
							id: "user_password",
							placeholder: "Your password",
						dom.div
							className:"text-left",	
							dom.input
								className: "radius-10",
								type: "checkbox",
							" Remember me"	
						dom.div	
							className: "large-8 large-centered columns",											
							dom.input
								className: "button expanded primary radius-40 white",
								type: "submit",
								value: "SIGNON"
							dom.a {},
								"Forgot your password?"
						dom.div
							className: "divider",
							dom.strong
								className: "divider-title",
								"Or",
						dom.a
							className: "button expanded btn-linkedin linkedin-color radius-10",
							href: @props.linkedin,
							dom.i
								className: "fa fa-linkedin-square fa-2x",
								'aria-hidden': "true",
							dom.span 
								className: "fntsize-25",
								" SIGNON with LinkedIn ",
						dom.p {},
							"Don't have an account?",
						dom.a
							href: "/users/sign_up",
							className: "bold",
							"SIGN UP"
			


