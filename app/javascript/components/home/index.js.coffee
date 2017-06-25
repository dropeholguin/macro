import React from "react"
import SignUp from "../signUp.js.coffee"

dom = React.DOM 

export default React.createClass
	displayName: 'Home'
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row expanded"
				style: {marginTop: "20px"}
				dom.div
					className: "large-6 columns"
					dom.div 
						className: "large-4 columns",
						dom.a
							href: @props.root_path,
							dom.img
								src: @props.img,
				dom.div
					className: "large-6 columns"
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
							className: "large-4 columns"
							dom.input
								type: "text"
								name: "user[email]",
								key: "email",
								id: "user_email"
								placeholder: "Your email",
						dom.div
							className: "large-4 columns"
							dom.input
								type: "password"
								name: 'user[password]',
								key: "password",
								id: "user_password",
								placeholder: "Your password",	
						dom.div
							className: "large-4 medium-6 small-6 columns"
							dom.input
								type: "submit"
								className: "button large radius-10"
								value: "SIGN ON"	
						dom.div							
							className: "large-4 medium-6 small-6 text-right columns"
							dom.a
								id: "button-register"
								style: {display: "none"}
								className: "button large radius-10"
								href: "users/sign_up"
								"REGISTER"					
			dom.div 
				className: "row expanded background-home",				
				dom.div
					className: "large-12 text-center columns margin-space white-title"
					dom.h2 
						className: "white-title",
						"JOIN OUR COMMUNITY OF SAS PROFESSIONALS"
					dom.h2 
						className: "white-title",
						"WITH MACRO CARDS"
					dom.h5 {},
						"Our platform gives you the tools to learn new things, share your expertise and further your career."
					dom.div
						className: "row",
						dom.div
							className: "large-4 large-centered columns",	
							dom.a
								className: "button expanded primary white blue-box",
								href: "/users/sign_up",
								"Register To Macro Cards »"
					dom.p {},
						"*We respect your privacy and have ZERO TOLERANCE for spam"
					dom.div
						className: "large-12 large-centered columns margin-space"
						dom.a
							id: "arrow",
							href: "#get-started",
							dom.img
								src: @props.arrow_img,
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
							src: @props.submit_img,
				dom.div
					className: "large-4 text-center columns plans",
					dom.h4 {},
						"Browse Cards - coming soon..."
					dom.p {},
						"Pick a topic and see the questions, answers and explanations."
					dom.div
						className: "small-6 large-8 small-centered large-centered columns",
						dom.img
							src: @props.card_img,
				dom.div
					className: "large-4 text-center columns plans",
					dom.h4 {},
						"Start Session - coming soon..."
					dom.p {},
						"Put your knowledge to the test with a timed session."
					dom.div
						className: "small-6 large-8 small-centered large-centered columns",
						dom.img
							src: @props.session_img,
			dom.div
				id: "about"
				className: "row expanded gray-box",
				dom.div
					className: "large-12 text-center columns",
					dom.h2 {},
						"ABOUT MACRO CARDS"
			dom.div
				id: "info"
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
								className: "fa fa-users fa-4x"
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
								className: "fa fa-pencil fa-4x"
						dom.div
							className: "small-10 medium-10 large-10 columns",
							dom.h4 {},
								"Put Your Technical Knowledge to the Test",
							dom.p {},
								"Challenge yourself by setting questions for other users. You’ll be creating accessible training for others and will gain reputation points for good questions. But first, you will have to answer questions that other users have set in order to prove your knowledge."
					dom.div
						className: "row",
						dom.div
							className: "small-2 medium-2 large-2 columns",
							dom.i
								className: "fa fa-bar-chart fa-4x"
						dom.div
							className: "small-10 medium-10 large-10 columns",
							dom.h4 {},
								"Maximise Performance",
							dom.p {},
								"Whether you’re a programmer or an administrator, our cards are an engaging way to learn more about the capabilities of SAS.  Macro Cards will give you the expertise to simplify, automate and maximise the performance of SAS within your organisation."

				dom.div
					className: "large-5 columns"
					React.createElement SignUp, large: "large-10", medium: "8", small: "10", csrfToken: @props.csrfToken,	
