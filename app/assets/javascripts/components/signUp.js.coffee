dom = React.DOM 


@SignUp = React.createClass
	displayName: 'SignUp'
	render: ->
		dom.div
			className: "root",
			dom.form {},
				dom.div
					className: "row",
					dom.div
						className: "small-9 medium-6 large-5 small-centered medium-centered large-centered columns text-center",
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
							placeholder: "Your name",
						dom.input
							className: "radius-10",
							type:  "text",
							placeholder: "Your email",
						dom.input
							className: "radius-10",
							type:  "password",
							placeholder: "Your password",
						dom.a
							className: "button expanded primary radius-40 white",
							"SIGN UP"
						dom.p {},
							"Already have an account?",
						dom.a 
							className: "bold",
							"SIGNON"
			


