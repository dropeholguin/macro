dom = React.DOM

@UserProfile = React.createClass

	render: ->
		displayName: 'UserProfile'
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "row lightblue-box margin-auto"
						dom.h4 {},
							"PROFILE"
						dom.p {},
							"See your personal info..."
					
					dom.div
						className: "row white-background",
						dom.div
							className: "large-3 columns",
							dom.div	{},
								dom.img
									className: "thumbnail",
									src: @props.user_pic,
						dom.div
							className: "large-9 columns"
							dom.h3 
								className: "bold",
								"Welcome #{@props.user.name}!"

