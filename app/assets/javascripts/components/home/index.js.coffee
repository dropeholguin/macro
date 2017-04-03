dom = React.DOM 

@Home = React.createClass
	displayName: 'Home'
	render: ->
		dom.div
			className: "root",
			dom.div 
				className: "row expanded background-home",
				dom.div
					className: "large-12 text-center columns margin-space white-title"
					dom.h2 
						className: "white-title",
						"JOIN OUR COMMUNITY OF SAS PROFESSIONALS"
					dom.h2 
						className: "white-title",
						"WITH SAS CARDS"
					dom.h5 {},
						"Our platform gives you the tools to learn new things, share your expertise and further your career."
					dom.div
						className: "row",
						dom.div
							className: "large-4 large-centered columns",	
							dom.a
								className: "button expanded primary white blue-box",
								href: "/users/sign_up",
								"Sign Up To SAS Cards »"
					dom.p {},
						"*We respect your privacy and have ZERO TOLERANCE for spam"
					dom.div
						className: "large-12 large-centered columns margin-space"
						dom.a
							id: "arrow",
							href: "#get-started",
							dom.img
								src: "/assets/arrow.png",
			dom.div
				className: "row expanded gray-box",
				dom.div
					id: "get-started",
					className: "large-12 text-center columns",
					dom.h2 {},
						"GET STARTED..."
			dom.div
				className: "row expanded white-background   ",
				dom.div
					className: "large-4 text-center columns plans",
					dom.h4 {},
						"Submit Questions"
					dom.p {},
						"Set questions for other users and collect reputation points."
					dom.div
						className: "small-6 large-8 small-centered large-centered columns",
						dom.img
							src: "/assets/submit.png",
				dom.div
					className: "large-4 text-center columns plans",
					dom.h4 {},
						"Browse Cards - coming soon..."
					dom.p {},
						"Pick a topic and see the questions, answers and explanations."
					dom.div
						className: "small-6 large-8 small-centered large-centered columns",
						dom.img
							src: "/assets/cards.png",
				dom.div
					className: "large-4 text-center columns plans",
					dom.h4 {},
						"Start Session - coming soon..."
					dom.p {},
						"Put your knowledge to the test with a timed session."
					dom.div
						className: "small-6 large-8 small-centered large-centered columns",
						dom.img
							src: "/assets/session.png",
			dom.div
				className: "row expanded gray-box",
				dom.div
					className: "large-12 text-center columns",
					dom.h2 {},
						"ABOUT SAS CARDS"
			dom.div
				className: "row expanded white-background margin-help margin-auto",
				dom.div
					id: "content-home",
					className: "large-7 columns"
					dom.div
						id: "first-content",
						className: "row",
						dom.div
							className: "small-2 medium-2 large-2 columns",
							dom.i
								className: "fa fa-users fa-5x"
						dom.div
							className: "small-10 medium-10 large-10 columns",
							dom.h4 {},
								"Belong to a Community of Experts",
							dom.p {},
								"Interact with other SAS professionals in order to learn new things, share your expertise and further your career."
					dom.div
						className: "row",
						dom.div
							className: "small-2 medium-2 large-2 columns",
							dom.i
								className: "fa fa-pencil fa-5x"
						dom.div
							className: "small-10 medium-10 large-10 columns",
							dom.h4 {},
								"Put Your Technical Knowledge to the Test",
							dom.p {},
								"Challenge yourself by setting questions for other users, you’ll be creating accessible training for others and you’ll gain reputation points for good questions. Or answers questions that other users have set in order to prove your knowledge."
					dom.div
						className: "row",
						dom.div
							className: "small-2 medium-2 large-2 columns",
							dom.i
								className: "fa fa-bar-chart fa-5x"
						dom.div
							className: "small-10 medium-10 large-10 columns",
							dom.h4 {},
								"Belong to a Community of Experts",
							dom.p {},
								"Interact with other SAS professionals in order to learn new things, share your expertise and further your career."

				dom.div
					className: "large-5 columns"
					React.createElement SignUp, large: "large-10", medium: "8", small: "10", csrfToken: @props.csrfToken,	

				




