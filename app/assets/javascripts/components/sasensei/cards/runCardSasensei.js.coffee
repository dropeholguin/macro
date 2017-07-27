dom = React.DOM 

@RunCardSasensei = React.createClass
	displayName: 'RunCard'
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
		timeLeft: +120000
		streak: @props.streak
		voteReasons: []
	componentDidMount: ->
		$(@refs.timer).countdown({since: new Date(), format: 'MS', layout: '{mn} {ml}, {sn} {sl}'})  
		$(@refs.showVotes).hide()
		$(document).foundation()
		if(@state.state)
			$(@refs.showVotes).hide()	
		$.ajax
			url: "/api/v1/vote_reasons"
			type: 'GET'
			success: (data) =>
				@setState({ voteReasons: data })
	loadNextCard: (data) ->	
		@setState({
			title: data.question.title,
			description: data.description,
			explanation: data.explanation,
			card_id: data.question.id
		})
		$(@refs.runCard).show()		
		$(@refs.explanationDiv).hide()
		$(@refs.nextCard).hide()	
		$(@refs.flagButton).hide()	
		$("input").prop('disabled', false)
		$(@refs.votesShow).hide()
		$(@refs.votesShow).find('button').prop('disabled', false)	# enables both voteUp/voteDown buttons
		$(@refs.reasonCardHolder).hide()
		$(@refs.statsHolder).hide()
		$(@refs.statsButton).hide()
		$(@refs.statsButton).find('a').hide()
		$(@refs.statsButton).find('a:first').show()
	answersUpdate: (data) ->
		@setState({answers: data.answers, choice: data.question.choice})
	tagsUpdate: (data) ->
		@setState({tag_list: data.tag_list})		
	handleClickVoteUp: (event) ->
		$.amaran content: {'title': 'Your vote', 'message': 'You have recently rated this card', 'info': "#{@props.votes} Votes", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
	handleClickVoteDown: (event) ->
		$.amaran content: {'title': 'Your vote', 'message': 'You have recently rated this card', 'info': "#{@props.votes} Votes", 'icon': 'fa fa-thumbs-o-down'}, theme: 'awesome error', delay: 10000

	verifyAnswer: (event) ->
		if @state.choice == 'user input'
			answerText = $('input[name=option]').val()
		else
			answerIds = $('input[name=option]:checked').map(-> @id).get()
			if answerIds.length < 1
				alert 'Select at least one answer'
				return
		$.ajax
			url: '/api/v1/cards/' + @state.card_id + '/verify'
			type: 'PUT'
			dataType: 'json'
			data: answerIds: answerIds, answerText: answerText
			error: ->
				console.log "AJAX Error:"
			success: (data) =>
				@setState({ animate_tag: "none", timeLeft: 0 })
				$(@refs.timer).countdown('toggle')
				$(@refs.flagButton).show()
				$(@refs.flagButton).addClass('animated bounceIn')
				document.getElementById('explanation-card').style.display = 'block'
				document.getElementById('run-card').style.display = 'none'
				document.getElementById('back-card').style.display = 'inline-block'
				$(@refs.animateTitle).removeClass('animated fadeInLeft')
				$(@refs.animateDescription).removeClass('animated fadeInRight')
				$(@refs.explanationDiv).addClass('animated fadeInDown')

				data.answers.forEach (answer) ->
					if answer.is_correct
						$('#' + answer.id).siblings('label').addClass("this-ans correct-bg animated bounceIn")
					else
						$('#' + answer.id).siblings('label').addClass("this-ansn")

				@setState({ state: data.state, streak: data.streak, votes: data.votes, is_passed: data.is_passed, time: data.time })
				if(data.state == false and data.streak >=5)
					$(@refs.showVotes).show()
				if (data.is_passed && data.time_long)
					$.amaran content: {'title': 'Well done!', 'message': '', 'info': "You have answered right #{@state.title}", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
					if(@state.streak < 9 and @state.streak >=5)
						$.amaran content: {'title': 'Well done!', 'message': '+1 TOKEN', 'info': "You have answered right #{@state.title}", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
					if(@state.streak > 9)
						$.amaran content: {'title': 'Well done!', 'message': '+2 TOKEN', 'info': "You have answered right #{@state.title}", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
				if (data.time_long == false)
					$.amaran content: {'title': 'Sorry!', 'message': '', 'info': "you took too long to answer this question! #{@state.title}", 'icon': 'fa fa-thumbs-o-down'}, theme: 'awesome error', delay: 10000
				if (data.is_passed == false && data.time_long == true)
					$.amaran content: {'title': 'Sorry!', 'message': '', 'info': "You have answered wrong #{@state.title}", 'icon': 'fa fa-thumbs-o-down'}, theme: 'awesome error', delay: 10000
				if (data.state == true)
					$(@refs.showVotes).hide()

				$("input").prop('disabled', true)
				$("#comment_comment_markdown").prop('disabled', false)
				$("#flag_form_input").prop('disabled', false)
				$(@refs.votesShow).show()
				$(@refs.statsButton).show()

	nextQuestionClicked: (event) ->	
		if(@state.is_passed == false)
			window.location.replace("/")	
		else
			$(@refs.timer).countdown('destroy')
			@setState(animate_tag: "animated fadeInRight")
			$(@refs.animateTitle).addClass('animated fadeInLeft')
			$(@refs.animateDescription).addClass('animated fadeInRight')
			next_card_path = @props.run_cards_path + window.location.search
			$.ajax
				url: next_card_path
				type: 'GET'
				dataType: 'json'
				error: ->
					console.log("AJAX Error:")
					window.location.replace("/")
				success: (data) =>
				    @setState({ quest: data, timeLeft: +120 })
		    		$(@refs.timer).countdown({ since: new Date(), format: 'MS', layout: '{mn} {ml}, {sn} {sl}'})
				    @loadNextCard(data)
				    @answersUpdate(data)
				    @tagsUpdate(data)
				    highlightAllCodes()
	statsClicked: (event) ->
		$(@refs.reasonCardHolder).hide()
		$(@refs.votesShow).find('button').prop('disabled', true)	# disables both voteUp/voteDown buttons
		$(@refs.statsButton).find('a').toggle()
		$(@refs.statsHolder).toggle()
		$("html, body").animate({ scrollTop: $(document).height() }, 1000);
	flagButtonClicked: (event)->
		$("#my_popup").popup() 
		console.log ("It Works!")
	voteUpClicked: (event) ->
		$(@refs.reasonCardHolder).hide()
		$(@refs.showVotes).hide()
		$(@refs.votesShow).find('button').prop('disabled', true)	# disables both voteUp/voteDown buttons
		$.ajax
			url: "api/v1/cards/#{@state.card_id}/vote"
			type: 'PUT',
			data: { vote_direction: 'up' }
		@setState(
			votes:  @state.votes + 1,
			state: true
		)
		$(@refs.voteTitle).text("Currently Rating:")
		$.amaran content: {'title': "You rated +1 for #{@props.title}", 'message': "", 'info': "", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
	voteDownClicked: (event) ->
		$(@refs.reasonCardHolder).show()
	reasonSelected: (event) ->
		if ($(@refs.reasonCard).val() == "0")
			return
		$(@refs.showVotes).hide()
		reasonValue = $(@refs.reasonCard).prop('disabled', true).val()
		$(@refs.votesShow).find('button').prop('disabled', true)	# disables both voteUp/voteDown buttons
		$.ajax
			url: "/api/v1/cards/#{@state.card_id}/vote",
			type: 'PUT',
			data: { vote_direction: 'down', vote_reason_id: reasonValue }
		@setState(
			votes:  @state.votes - 1
			state: true
		)
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
		if(@state.streak <= 0)
			streakRemains = "4"
			msgSPDE = "TO START SPDE MODE!"
		else if(@state.streak > 0 and @state.streak <= 1)
			streakRemains = "3"
			msgSPDE = "TO START SPDE MODE!"
		else if(@state.streak > 1 and @state.streak <= 2)
			streakRemains = "2"	
			msgSPDE = "TO START SPDE MODE!"
		else if(@state.streak > 2 and @state.streak <= 3)
			streakRemains = "1"	
			msgSPDE = "TO START SPDE MODE!"
		else if(@state.streak > 3 and @state.streak <= 4)
			streakRemains = "0"
			msgSPDE = "SPDE MODE - ENABLED"
		else if(@state.streak > 4)	
			streakRemains = "You are on"
			msgSPDE = "SPDE MODE!" 					
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "row text-center link-stats",
						dom.div
							className: "large-12 columns"
							dom.span 
								style: {fontStyle: "italic"},
								"STIMER "
							dom.i
								className: "fa fa-clock-o",
							dom.span {},
								" ",	
							dom.span
								ref: "timer",
					dom.div
						className: "question-background"
						dom.div
							style:	{fontSize: "16px"}
							className: "large-8 large-centered columns"
							dangerouslySetInnerHTML: __html: @state.description.toString(),
					dom.div
						className: "answers"
						for answer in @state.answers
							React.createElement CardAnswerSasensei, key: answer.id, answer: answer, choice: @state.choice
					dom.div 
						className: "text-center"
						dom.a
							style: {width: "100%"}
							className: "button btn-run menu-title uppercase",
							onClick: @verifyAnswer,
							ref: "runCard",
							id: "run-card",
							"RUN"
					dom.div
						id: "explanation-card",
						ref: "explanationDiv",
						style: {display: 'none'}
						className: "question-background"
						dom.div
							style:	{fontSize: "16px"}
							className: "large-8 large-centered columns uppercase menu-subtitle"
							dangerouslySetInnerHTML: __html: @state.explanation.toString()
					dom.div
						className: "row"
						dom.div
							ref: "votesShow"
							className: "small-4 columns text-center"
							style: {display: "none"}
							dom.button 
								className: "upvote"
								onClick: @voteUpClicked,
							dom.button 
								className: "downvote"
								onClick: @voteDownClicked,
						dom.div
							ref: "reasonCardHolder",
							className: "small-4 columns text-center"
							style: {display: "none"}
							dom.select
								ref: "reasonCard",
								className: "btn-run menu-title",
								onChange: @reasonSelected,
								dom.option
									value: "0", 
									"Choose Issue"
								@state.voteReasons.map (reason) -> 
									dom.option
										value: reason.id, 
										reason.text
						dom.div
							className: "small-4 columns text-center pull-right"
							dom.a
								style: {width: "100%", display: "none"}
								className: "button btn-run menu-title uppercase",
								id: "back-card",
								ref: "nextCard",
								onClick: @nextQuestionClicked,
								"Next"
						dom.div
							ref: "statsButton"
							className: "large-12 columns text-center"
							style: {display: "none"}
							dom.a
								'data-tooltip': '',
								'aria-haspopup': 'true',
								'data-disable-hover': 'false',
								'data-hover-delay': '0',
								tabIndex: '1', 
								title: "You will not be able to vote after seeing stats.",
								className: "uppercase link-stats has-tip tip-top",
								onClick: @statsClicked,
								"Show stats"
							dom.a
								style: {display: "none"},
								className: "uppercase link-stats",
								onClick: @statsClicked,
								"Hide stats"
					dom.div
						ref: "statsHolder",
						className: "statsHolder",
						style: {display: "none"}


							



					





