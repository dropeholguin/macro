dom = React.DOM

@SessionIndex = React.createClass

	render: ->
		displayName: 'Session'
		dom.div
			className: "root",
			dom.div
				className: "large-12 text-center columns plans",
				dom.div
					className: "session-pink-box",	
					dom.h4 {},
						@props.title
					dom.div {},
						"Pass this test and gain new privileges!",
					dom.div {}, 									 	
				dom.div
					className: "white-background radius-bottom",
					dom.div
						className: "small-6 large-10 small-centered large-centered columns img-home",
						dom.img
							src: @props.session_img,
					dom.p 
						className: "bold",
						"TOTAL CARDS: #{@props.count}"
					dom.div
						className: "row margin-20",
						dom.div
							className: "large-8 large-centered columns",
							dom.a
								href: @props.run_sessions_path,
								className: "button large radius-10 orange",
								"RUN"						


