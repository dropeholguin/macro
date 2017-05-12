dom = React.DOM 

@SessionStats = React.createClass
	displayName: 'SessionStats'
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "row lightblue-box margin-auto"
						dom.h4 {},
							"Statistical Analysis Section"
						dom.p {},
							"Analyze your performance on this session."
					dom.div
						className: "row white-background",
						dom.div
							className: "row",
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-hashtag",
										" Correct cards answered: #{@props.cont}"
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-check",
										" Session taken: #{@props.percentage_session} %"
						dom.div
							className: "row",
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-line-chart ",
										" Passed Session: #{@props.passed_session}"
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-users",
										" Well answered by: #{@props.percentage_people} % of users"

