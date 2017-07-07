dom = React.DOM 

@LoginSasensei = React.createClass
	displayName: 'Login'

	getDefaultProps: ->
		privacy_path: ''
		terms_path: ''

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
							style: { marginTop: "30px" }
							React.createElement LinkedInButton
							React.createElement GoogleButton
							React.createElement FacebookButton
							dom.div
								className: 'login-privacy-text'
								dangerouslySetInnerHTML: __html: "By using sasensei you agree to our <a href=#{@props.privacy_path}>Privacy Policy</a> and <a href=#{@props.terms_path}>Terms and Conditions</a>"
