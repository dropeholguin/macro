dom = React.DOM 


@SignIn = React.createClass
	displayName: 'SignIn'
	render: ->
		dom.div
			className: "root",
			dom.form {},
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
							placeholder: "Your email",
						dom.input
							className: "radius-10",
							type:  "password",
							placeholder: "Your password",
						dom.div
							className:"text-left",	
							dom.input
								className: "radius-10",
								type: "checkbox",
							" Remember me"	
						dom.div	
							className: "large-8 large-centered columns",											
							dom.a
								className: "button expanded primary radius-40 white",
								"SIGNON"
							dom.a {},
								"Forgot your password?"
						dom.div
							className: "divider",
							dom.strong
								className: "divider-title",
								"Or",
						dom.a
							className: "button expanded btn-linkedin linkedin-color radius-10",
							dom.i
								className: "fa fa-linkedin-square fa-2x",
								'aria-hidden': "true",
							dom.span 
								className: "fntsize-25",
								" SIGNON with LinkedIn ",
						dom.p {},
							"Don't have an account?",
						dom.a 
							className: "bold",
							"SIGN UP"
			


