dom = React.DOM 

@SessionStats = React.createClass
	displayName: 'SessionStats'
	getInitialState: ->
		number_cards_correct: @props.score.number_cards_correct
	componentDidMount: ->
		if @props.score.number_cards_correct == null
			@setState({number_cards_correct: 0})
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
							"Analyse your performance on this session."
					dom.div
						className: "row white-background",
						dom.div
							className: "row",
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-hashtag",
										" You got #{@props.cont} correct (#{@props.percentage_session}%)"
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-check",
										"You ranked ?? out of ?? on this session"
						dom.div
							className: "row",
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-line-chart ",
										" Result: #{@props.result}"
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-users",
										" Average score: ??%"
						dom.div
							className: "row",
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-clock-o ",
										" Total time: #{@props.time_at}s"
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-user-plus",
										" #{@props.percentage_people}% of users achieved 75% or above in this session."
						dom.div
							className: "row",
							dom.div
								className: "large-12 columns",
								dom.h4
									className: "text-center",
									"Highest Score"
						dom.div
							className: "row",
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-user ",
										" Name: #{@props.user}"
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-clock-o ",
										" Best time: #{@props.time_at_score}s"
						dom.div
							className: "row",
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-check ",
										" Cards well answered: #{@state.number_cards_correct }"
							dom.div
								className: "large-6 columns",	
								dom.h5 {},	
									dom.li
										className: "fa fa-percent ",
										" Percentage: #{@props.score.percentage}%"



