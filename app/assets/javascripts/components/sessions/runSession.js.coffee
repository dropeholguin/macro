dom = React.DOM 

@RunSession = React.createClass
	displayName: 'RunSession'
	getInitialState: ->
		right_answer: "0"
		votes: @props.votes
		comments: []
		state: @props.state
		quest: []
		title: @props.title
		description: @props.description
		explanation: @props.explanation
		card_id: @props.card_id	
		answers: @props.answers
		tag_list: @props.tag_list
		choice: @props.choice
		animate_tag: "animated fadeInRight"
	componentDidMount: ->
		$(@refs.animateTitle).addClass('animated fadeInLeft')
		$(@refs.animateDescription).addClass('animated fadeInRight')
		$(@refs.showVotes).hide()
		if(@state.state)
			$(@refs.showVotes).hide()
		if(@state.state == false)
			$(@refs.showComments).hide()
	infoUpdate: (data) ->	
		console.log (data)		
		@setState({title: data.question.title, description: data.question.description_markdown, explanation: data.question.explanation_markdown, card_id: data.question.id})
		$(@refs.runCard).show()		
		$(@refs.explanationDiv).hide()
		$(@refs.nextCard).hide()	
		$(@refs.flagButton).hide()	
		$(@refs.votesDiv).hide()
		$("input").prop('disabled', false)
	answersUpdate: (data) ->
		console.log ("Answers: "+data.answers[0].id)
		@setState({answers: data.answers, choice: data.question.choice})
	tagsUpdate: (data) ->
		@setState({tag_list: data.tag_list})
	handleClickVoteUp: (event) ->
		$.amaran content: {'title': 'Your vote', 'message': 'You have recently rated this card', 'info': "#{@props.votes} Votes", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
	handleClickVoteDown: (event) ->
		$.amaran content: {'title': 'Your vote', 'message': 'You have recently rated this card', 'info': "#{@props.votes} Votes", 'icon': 'fa fa-thumbs-o-down'}, theme: 'awesome error', delay: 10000
	handleClick: (event) ->
		@setState({animate_tag: "none"})   
		if(@state.state == false)
			$(@refs.showVotes).show()
		$(@refs.votesDiv).hide()
		$(@refs.votesDiv).addClass("small-12 text-center animated bounce")
		$(@refs.flagButton).hide()
		$(@refs.flagButton).addClass('animated bounceIn')
		document.getElementById('run-card').style.display = 'none'
		document.getElementById('back-card').style.display = 'inline-block'
		$(@refs.animateTitle).removeClass('animated fadeInLeft')
		$(@refs.animateDescription).removeClass('animated fadeInRight')
		
		selected = $('input[name=option]:checked').map(-> @id).get()
		$.ajax 
			url: @props.run_cards_path
			type: 'POST'
			dataType: 'json'
			data: checkbox: selected, card_id: @state.card_id
			error: ->
				console.log("AJAX Error:")
			success: (data) =>
			    console.log(data.answers)
      	console.log ("This is selected: "+selected+@state.card_id) 
      	$("input").prop('disabled', true)       	 
	nextQuestionClicked: (event) ->
		$(@refs.animateTitle).addClass('animated fadeInLeft')
		$(@refs.animateDescription).addClass('animated fadeInRight')
		$.ajax '/sessions_next_card',
        type: 'POST',
        dataType: 'json',
        error: ->
            console.log("AJAX Error:")
            window.location.replace("/sessions")
        success: (data) =>
            console.log(data)
            @setState({quest: data}) 
            @infoUpdate(data) 
            @answersUpdate(data)
            @tagsUpdate(data)
        @setState(animate_tag: "animated fadeInRight")
	flagButtonClicked: (event)->
		$("#my_popup").popup() 
		console.log ("It Works!")
	voteUpClicked: (event) ->
		$(@refs.showVotes).hide()
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
		$(@refs.showVotes).hide()
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
	render: ->	
		if(@state.votes > 0)
			rateColor = "rate-green"
		if(@state.votes < 0)
			rateColor = "rate-red"
		if(@state.votes > 1 or @state.votes < -1)
			numVotes = "Votes"
		else
			numVotes = "Vote"	
		if(@props.streak <= 0)
			streakRemains = "5"
			msgSPDE = "TO START SPDE MODE!"
		else if(@props.streak > 0 and @props.streak <= 1)
			streakRemains = "4"
			msgSPDE = "TO START SPDE MODE!"
		else if(@props.streak > 1 and @props.streak <= 2)
			streakRemains = "3"	
			msgSPDE = "TO START SPDE MODE!"
		else if(@props.streak > 2 and @props.streak <= 3)
			streakRemains = "2"	
			msgSPDE = "TO START SPDE MODE!"
		else if(@props.streak > 3 and @props.streak <= 4)
			streakRemains = "1"
			msgSPDE = "TO START SPDE MODE!"
		else if(@props.streak > 4)	
			streakRemains = "You are on"
			msgSPDE = "SPDE MODE!" 					
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "row lightblue-box margin-auto"
						dom.h4 {},
							"RUN A SESSION"
						dom.p {},
							"Choose a topic, take sessions one by one and get bonuses for 4 in a row."
					
					dom.div
						className: "row white-background",
						dom.div
							className: "answer-container large-8 columns"
							dom.div
								className: "row",
								dom.div
									className: "large-9 columns",								
									dom.h4
										ref: "animateTitle",
										className: "weight",
										style: {color: "#07C", fontWeight: "bold"},
										@state.title,
								dom.div
									className: "large-3 columns text-right",
									dom.button
										ref: "flagButton",
										style: {display: "none"},
										className: "button small hollow alert my_popup_open",
										onClick: @flagButtonClicked,
										"Report"										
							dom.div
								ref: "animateDescription",
								dangerouslySetInnerHTML: __html: @state.description.toString(),
							dom.div
								className: "row",								
								dom.div 
									className: "small-6 columns",
									dom.h5
										className: "weight",
										"Answers:"
									for answer in @state.answers
										React.createElement CardAnswer, key: answer.id, answer: answer, choice: @state.choice, right_answer: @state.right_answer
								dom.div
									id: "explanation-card",
									ref: "explanationDiv",										
									style: {display: 'none'}
									className: "small-6 columns",
									dom.h5
										className: "weight",
										"Explanation:"
									dom.p 
										dangerouslySetInnerHTML: __html: @state.explanation.toString()										
							dom.div
								className: "row",
								dom.div
									className: "small-8 columns",
									for tag in @state.tag_list
										React.createElement TagList, key: tag.id, tag: tag, animate_tag: @state.animate_tag,
																	
								dom.div
									className: "small-12 columns text-right",
									dom.a 
										id: "run-card",
										className: "button large radius-10",
										onClick: @handleClick,
										ref: "runCard",
										"ANSWER"																							
								dom.div
									className: "small-12 columns text-right",
									dom.a 
										id: "back-card",
										ref: "nextCard",											
										onClick: @nextQuestionClicked,
										style: {display: 'none'},
										className: "button large radius-10",
										"NEXT",								
								dom.div
									style: {display: "none"}
									ref: "votesDiv",
									className: "small-12 columns",
									dom.p
										ref: "voteTitle",
										className: "weight",
										style: {color: "#07C", fontWeight: "bold"},
										"Currently rating for this card:",
									dom.div
										className: "small-12 columns text-center"
										dom.i
											className: "fa fa-star-o "+rateColor,	
										dom.span
											className: rateColor,
											onChange: @voteChanged,	
											" #{@state.votes} " + numVotes,

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
							className: "large-4 columns",	
							dom.div
								className: "small-12 columns",
								dom.span 
									dom.div
										className: "large-8 large-centered columns infinite"
										dom.img
											src: @props.img
									dom.div										
										className: "text-center spde-mode",																			
										dom.h2 			
											ref: "mode",																		
											className: "spde-mode",
											streakRemains,
										dom.div
											className: "spde-mode-title",
						


