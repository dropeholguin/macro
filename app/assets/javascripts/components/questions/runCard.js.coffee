dom = React.DOM 

@RunCard = React.createClass
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
		timeLeft: +120
		streak: @props.streak
	componentDidMount: ->
		$(@refs.timer).countdown({until: @state.timeLeft, format: 'MS', layout: '{mn} {ml}, {sn} {sl}', onExpiry: @handleClick})
		$(@refs.showVotes).hide()
		$(@refs.showComments).hide()
		$(@refs.cardStats).hide()
		if(@state.state)
			$(@refs.showVotes).hide()	
	infoUpdate: (data) ->	
		console.log (data)		
		@setState({title: data.question.title, description: data.description, explanation: data.explanation, card_id: data.question.id})
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
		@setState({animate_tag: "none", timeLeft: 0})
		$(@refs.timer).countdown('toggle')				
		$(@refs.votesDiv).show()
		$(@refs.votesDiv).addClass("small-12 text-center animated bounce")
		$(@refs.flagButton).show()
		$(@refs.flagButton).addClass('animated bounceIn')
		document.getElementById('explanation-card').style.display = 'block'
		document.getElementById('run-card').style.display = 'none'
		document.getElementById('back-card').style.display = 'inline-block'
		$(@refs.animateTitle).removeClass('animated fadeInLeft')
		$(@refs.animateDescription).removeClass('animated fadeInRight')
		$(@refs.explanationDiv).addClass('animated fadeInDown')
		if ($('.this-ans').length > 0)
			$('.this-ans').addClass "right-color animated bounceIn"
		if ($('.this-ansn').length > 0)
			$('.this-ansn').addClass "wrong-color"
		selected = $('input[name=option]:checked').map(-> @id).get()
		if (@state.choice == "user input")
			user_input = $('input[name=option]').val()
			console.log ("User input: " + user_input)
		$.ajax 
			url: '/run_question'
			type: 'POST'
			dataType: 'json'
			data: checkbox: selected, card_id: @state.card_id, user_input: user_input
			error: ->
				console.log("AJAX Error:")
			success: (data) =>
			    console.log(data)
			    @setState({creator: data.creator.name, created_at: data.created_at, people_number: data.people_number, percentage_people: data.percentage_people, state: data.state, streak: data.streak, votes: data.votes, is_passed: data.is_passed, time: data.time }) 
			    if(data.state == false and data.streak >=5)
			    	$(@refs.showVotes).show()
			    	$(@refs.cardStats).hide()
			    	$(@refs.cardStats).removeClass('animated fadeInDown')
		    	if (data.is_passed)
		    		$.amaran content: {'title': 'Well done!', 'message': '', 'info': "You have answered right #{@state.title}", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
		    		if(@state.streak < 9 and @state.streak >=5)
            			$.amaran content: {'title': 'Well done!', 'message': '+1 TOKEN', 'info': "You have answered right #{@state.title}", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
	    			if(@state.streak > 9)
	    				$.amaran content: {'title': 'Well done!', 'message': '+2 TOKEN', 'info': "You have answered right #{@state.title}", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
		    	if (data.is_passed == false)
	    			$.amaran content: {'title': 'Sorry!', 'message': '', 'info': "You have answered wrong #{@state.title}", 'icon': 'fa fa-thumbs-o-down'}, theme: 'awesome error', delay: 10000
		    	if (data.state == true)
		    		$(@refs.showVotes).hide()
		    		$(@refs.showComments).show()
		    		$(@refs.cardStats).show()
					$(@refs.cardStats).addClass('animated fadeInDown')
      	console.log ("This is selected: "+selected) 
		$("input").prop('disabled', true) 
		$("#comment_comment_markdown").prop('disabled', false)
		$("#flag_form_input").prop('disabled', false)    		
	nextQuestionClicked: (event) ->	
		if(@state.is_passed == false)
			window.location.replace("/")	
		else
			$(@refs.timer).countdown('destroy')
			$(@refs.showComments).hide()
			$(@refs.cardStats).removeClass('animated fadeInDown')
			$(@refs.cardStats).hide()
			@setState(animate_tag: "animated fadeInRight")
			$(@refs.animateTitle).addClass('animated fadeInLeft')
			$(@refs.animateDescription).addClass('animated fadeInRight')
			$.ajax
				url: @props.run_cards_path
				type: 'POST'
				dataType: 'json'
				error: ->
					console.log("AJAX Error:")
					window.location.replace("/")
				success: (data) =>
				    console.log(data)
				    @setState({quest: data, timeLeft: +120})
		    		$(@refs.timer).countdown({until: @state.timeLeft, format: 'MS', layout: '{mn} {ml}, {sn} {sl}', onExpiry: @handleClick})   		
				    @infoUpdate(data)
				    @answersUpdate(data)
				    @tagsUpdate(data)
				    highlightAllCodes()
	flagButtonClicked: (event)->
		$("#my_popup").popup() 
		console.log ("It Works!")
	voteUpClicked: (event) ->
		$(@refs.showVotes).hide()
		$(@refs.cardStats).show()
		$(@refs.cardStats).addClass('animated fadeInDown')
		$.ajax
			url: "/questions/#{@state.card_id}/vote?type=up"
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
		$(@refs.cardStats).show()
		$(@refs.cardStats).addClass('animated fadeInDown')
		$.ajax
			url: "/questions/#{@state.card_id}/vote?type=down"
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
								className: "row text-right",
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
										"RUN"																	
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
										ref: "cardStats",
										className: "large-12 columns",
										React.createElement CardStats, creator: @state.creator, created_at: @state.created_at, people_number: @state.people_number, percentage_people: @state.percentage_people, time: @state.time				
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
											msgSPDE,
						dom.div	
							className: "row",
							ref: "showComments",			
							dom.div
								className: "large-8 columns",
								React.createElement Comments, csrfToken: @props.csrfToken, url: "/questions/#{@state.card_id}/comments", comments: @props.comments		
						dom.div
							className: "row"
							ref: "flags"
							React.createElement FlagForm, card_id: @state.card_id, csrfToken: @props.csrfTokenFlag,
@RunCardAnswer = React.createClass
	displayName: 'RunCardAnswer'
	componentDidMount: ->
		$(@refs.optionToSelect).addClass('animated fadeInUp')
	render: ->
		if(@props.choice == "simple")
			typeOption = "radio"
		else if(@props.choice == "multiple")
			typeOption = "checkbox"
		else if(@props.choice == "user input")
			rightColor: "none"
		if(@props.answer.is_correct)
			rightColor = "this-ans" 
		else
			rightColor = "this-ansn"
		dom.div
			ref: "optionToSelect",
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
						@props.answer.answer_markdown				
			
@RunTagList = React.createClass
	displayName: 'RunTagList'
	render: ->			
		dom.li 
			className: "margin-tag title-li tag-horizontal",
			dom.a
				className: "tag-decoration",
				@props.tag

@CardStats = React.createClass
	displayName: 'CardStats'
	getDefaultProps: ->
		creator: "No info"
		created_at: "No info"
		people_number: "0"
		percentage_people: "0"
		time: "0"
	render: ->
		dom.div
			className: "root text-center",
			dom.div
				className: "row",
				dom.div
					className: "large-12 columns",
					dom.h5
						style: {color: "#cc4b37"},
						className: "bold",
						"Statistical Analysis Section",	
			dom.div
				className: "row",
				dom.div
					className: "large-6 columns",	
					dom.h5 {},	
						dom.li
							className: "fa fa-user",
							" Created by: #{@props.creator}"
				dom.div
					className: "large-6 columns",	
					dom.h5 {},	
						dom.li
							className: "fa fa-calendar",
							" Created at: #{@props.created_at}"
			dom.div
				className: "row",
				dom.div
					className: "large-6 columns",	
					dom.h5 {},	
						dom.li
							className: "fa fa-users",
							" Taken by: #{@props.people_number} Users"
				dom.div
					className: "large-6 columns",	
					dom.h5 {},	
						dom.li
							className: "fa fa-check",
							" Well answered by: #{@props.percentage_people} %"
			dom.div
				className: "row",
				dom.div
					className: "large-6 columns",	
					dom.h5 {},	
						dom.li
							className: "fa fa-clock-o",
							" Total time: #{@props.time}s"	
	
@RunCardFilter = React.createClass
	getDefaultProps: ->
		number_questions: 0
	componentDidMount: ->
		$(@refs.arrow).addClass('animated pulse infinite')
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row radius-10",
				style: {border: "1px solid #cacaca"}				
				dom.div
					className: "large-12 columns"
					dom.h4 
						style: {fontStyle: "italic", fontWeight: "bold"},
						if @props.total > 0	
							"#{@props.number_questions} Cards Available"
						else
							"To start choose a topic or type a related card"					
					dom.div
						className: "large-12 columns",
						if @props.total > 0	
							dom.a
								className: "button radius-10",
								href: @props.run_cards_path,
								dom.i
									className: "fa fa-play"
								" RUN"
						else
							dom.i
								ref: "arrow" 
								style: {color: "#169bd4"}
								className: "fa fa-play-circle fa-5x"
							



					





