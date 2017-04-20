dom = React.DOM 

@ShowCard = React.createClass
	displayName: 'ShowCard'
	getInitialState: ->
		right_answer: "0"
	componentDidMount: ->
		$("input").prop('disabled', true)
	render: ->	
		if(@props.votes > 0)
			rateColor = "rate-green"
		if(@props.votes < 0)
			rateColor = "rate-red"
		if(@props.votes > 1 or @props.votes < -1)
			numVotes = "Votes"
		else
			numVotes = "Vote"	
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "row lightblue-box margin-auto"
						dom.h4 {},
							"RUN A CARD"
						dom.p {},
							"Choose a topic, take questions one by one and get bonuses for 4 in a row."
					
					dom.div
						className: "row white-background",
						dom.div
							className: "answer-container large-8 large-centered columns"
							dom.h4
								className: "weight",
								style: {color: "#07C", fontWeight: "bold"},
								@props.title,
							dom.div
								dangerouslySetInnerHTML: __html: @props.description.toString(),
							dom.div
								className: "row",								
								dom.div 
									className: "small-6 columns",
									dom.h5
										className: "weight",
										"Answers:"
									for answer in @props.answers
										React.createElement CardAnswer, key: answer.id, answer: answer, choice: @props.choice, right_answer: @state.right_answer
								dom.div
									id: "explanation-card",
									style: {display: 'none'}
									className: "small-6 columns",
									dom.h5
										className: "weight",
										"Explanation:"
									dom.p 
										dangerouslySetInnerHTML: __html: @props.explanation.toString()										
							dom.div
								className: "row",
								dom.div
									className: "small-8 columns",
									for tag in @props.tag_list
										React.createElement TagList, key: tag.id, tag: tag,
																	
								dom.div
									className: "small-12 columns text-right",
									dom.a 
										id: "run-card",
										className: "button large radius-10",
										href: "/questions",
										ref: "runCard",
										"BACK"								
								if(@props.current_user and @props.current_user_voted)		
									dom.div
										className: "small-12 columns",
										dom.p
											className: "weight",
											style: {color: "#07C", fontWeight: "bold"},
											"Rate this card:",
										dom.div
											className: "small-6 columns"
											dom.i
												className: "fa fa-star-o "+rateColor,	
											dom.span
												className: rateColor,
												" #{@props.votes} "+numVotes,	
										dom.div
											className: "small-6 columns text-right"								
											dom.a
												style: {marginRight: "5px"},
												className: "button hollow small secondary radius-10",
												href: @props.vote_up,
												onClick: @handleClickVoteUp,
												'data-method': 'post'
												dom.i
													className: "fa fa-thumbs-o-up"
											dom.a
												className: "button hollow small secondary radius-10",
												href: @props.vote_down,
												onClick: @handleClickVoteDown,
												'data-method': 'post'
												dom.i
													className: "fa fa-thumbs-o-down",																	

@CardAnswer = React.createClass
	displayName: 'CardAnswer'
	render: ->
		if(@props.choice == "simple")
			typeOption = "radio"
		else if(@props.choice == "multiple")
			typeOption = "checkbox"
		if(@props.answer.is_correct)
			rightColor = "this-ans" 
		else
			rightColor = "this-ansn"
		dom.div
			className: "root margin-15 answer-card "+rightColor,
			dom.div
				className: "row",							
				dom.div 
					className: "small-12 columns",
					dom.input
						id: "#{@props.answer.id}",
						name: "option",
						type: typeOption,	
					dom.label
						htmlFor: "#{@props.answer.id}",
						dangerouslySetInnerHTML: __html: @props.answer.answer_markdown.toString()				
			
@TagList = React.createClass
	displayName: 'TagList'
	render: ->			
		dom.li 
			className: "margin-tag title-li tag-horizontal",
			dom.a
				className: "tag-decoration",
				@props.tag


