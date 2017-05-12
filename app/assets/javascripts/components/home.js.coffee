dom = React.DOM 

@HomeLoggedIn = React.createClass
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row",
				dom.div
					className: "large-10 large-centered columns",					
					dom.div
						className: "row expanded",
						dom.div
							className: "large-4 text-center columns plans",
							dom.div
								className: "submit-green-box",	
								dom.h4 {},
									"SUBMIT"
								dom.div {},
									"Add more — get more!",
								dom.div {}, 
								 	"Help community to grow!"
							dom.div
								className: "white-background radius-bottom",
								dom.div
									className: "small-6 large-10 small-centered large-centered columns img-home",
									dom.img
										src: @props.submit_img,
								dom.div
									className: "row margin-20",
									dom.div
										className: "large-8 large-centered columns",
										dom.a
											className: "button large radius-10",
											href: "/questions/new",
											"SUBMIT"
						dom.div
								className: "large-4 text-center columns plans",
								dom.div
									className: "card-blue-box",	
									dom.h4 {},
										"CARDS"
									dom.div {},
										"Answer questions one by one.",
									dom.div {}, 									 	
								dom.div
									className: "white-background radius-bottom",
									dom.div
										className: "small-6 large-10 small-centered large-centered columns img-home",
										dom.img
											src: @props.card_img,
									dom.div
										className: "row margin-20",
										dom.div
											className: "large-8 large-centered columns",
											dom.a
												className: "button large radius-10",
												href: "/questions",
												"RUN"
						dom.div
								className: "large-4 text-center columns plans",
								dom.div
									className: "session-pink-box",	
									dom.h4 {},
										"SESSIONS"
									dom.div {},
										"Pass a test — gain new privileges!",
									dom.div {}, 									 	
								dom.div
									className: "white-background radius-bottom",
									dom.div
										className: "small-6 large-10 small-centered large-centered columns img-home",
										dom.img
											src: @props.session_img,
									dom.div
										className: "row margin-20",
										dom.div
											className: "large-8 large-centered columns",
											dom.a
												href: "/sessions",
												className: "button large radius-10 orange",
												"RUN"						



