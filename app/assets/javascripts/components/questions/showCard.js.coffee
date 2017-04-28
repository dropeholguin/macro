dom = React.DOM 

@ShowCard = React.createClass
	displayName: 'ShowCard'
	getInitialState: ->
		right_answer: "0"
		votes: @props.votes
		comments: []
		state: @props.state
	componentDidMount: ->
		$(@refs.anim1).addClass('animated fadeInUp')
		$(@refs.anim2).addClass('animated pulse')
		@props.votes
		if(@state.state)
			$(@refs.showVotes).hide()			
		if(@state.state == false)
			$(@refs.showComments).hide()
	componentWillMount: ->
		if(@state.state)
			$(@refs.showComments).show()
	voteUpClicked: (event) ->
		$.ajax
			url: @props.vote_up
			type: 'post'
		@setState(
			votes:  @state.votes + 1,
			state: true
		)
		$(@refs.showComments).show()		
		$(@refs.voteDown).hide()
		$(@refs.voteUp).hide()
		$(@refs.numVotesDiv).removeClass("small-6")
		$(@refs.numVotesDiv).addClass("small-12 text-center animated bounce")
		$(@refs.voteTitle).text("Currently Rating:")
		$.amaran content: {'title': "You rated +1 for #{@props.title}", 'message': "", 'info': "", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
	voteDownClicked: (event) ->
		$.ajax
			url: @props.vote_down
			type: 'post'		
		@setState(
			votes:  @state.votes - 1
			state: true
		)
		$(@refs.showComments).show()
		$(@refs.voteDown).hide()
		$(@refs.voteUp).hide()
		$(@refs.numVotesDiv).removeClass("small-6")
		$(@refs.numVotesDiv).addClass("small-12 text-center animated bounce")
		$(@refs.voteTitle).text("Currently Rating:")
		$.amaran content: {'title': "You rated -1 for #{@props.title}", 'message': "", 'info': "", 'icon': 'fa fa-thumbs-o-down'}, theme: 'awesome error', delay: 10000
	flagButtonClicked: (event)->
		 $("#my_popup").popup()
	voteChanged: (event) ->
		@state.votes = event.target.value
		@forceUpdate()
	render: ->	
		if(@state.votes > 0)
			rateColor = "rate-green"
		if(@state.votes < 0)
			rateColor = "rate-red"
		if(@state.votes > 1 or @state.votes < -1)
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
						ref: "test",
						className: "row lightblue-box margin-auto"
						dom.h4 {},
							"RUN A CARD"
						dom.p {},
							"Choose a topic, take questions one by one and get bonuses for 4 in a row."
					
					dom.div
						className: "row white-background",
						dom.div
							className: "answer-container large-8 columns"
							dom.div
								className: "row",
								dom.div
									className: "large-9 columns",
									dom.h4
										className: "weight",
										style: {color: "#07C", fontWeight: "bold"},
										@props.title,
								dom.div
									className: "large-3 columns text-right",
									dom.button
										className: "button small hollow alert my_popup_open",
										onClick: @flagButtonClicked,
										"Report"	
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
										ref: "showVotes",
										className: "small-12 columns",
										dom.p
											ref: "voteTitle",
											className: "weight",
											style: {color: "#07C", fontWeight: "bold"},
											"Rate this card:",
										dom.div
											ref: "numVotesDiv",
											className: "small-6 columns"
											dom.i
												className: "fa fa-star-o "+rateColor,	
											dom.span
												className: rateColor,
												onChange: @voteChanged,	
												" #{@state.votes} " + numVotes,	
										dom.div
											className: "small-6 columns text-right"								
											dom.a
												ref: "voteUp",
												style: {marginRight: "5px"},
												className: "button hollow small secondary radius-10",
												onClick: @voteUpClicked,
												dom.i
													className: "fa fa-thumbs-o-up"
											dom.button
												ref: "voteDown",
												className: "button hollow small secondary radius-10",
												onClick: @voteDownClicked,
												dom.i
													className: "fa fa-thumbs-o-down",										
						dom.div
							className: "small-4 columns",
							dom.span 
								dom.div
									className: "large-8 large-centered columns infinite"
									ref: "anim2",
									dom.img
										src: @props.img
								dom.div
									className: "text-center spde-mode",
									ref: "anim1",
									"You're on"
									dom.div
										className: "spde-mode-title",
										"SPDE MODE!"
						dom.div	
							className: "row",
							ref: "showComments",			
							dom.div
								className: "large-8 columns",
								React.createElement Comments, csrfToken: @props.csrfToken, url: "/questions/#{@props.card_id}/comments", comments: @props.comments		

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


