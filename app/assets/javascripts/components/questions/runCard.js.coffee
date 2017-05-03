dom = React.DOM 

@RunCard = React.createClass
	displayName: 'RunCard'
	getInitialState: ->
		right_answer: 0
	handleClickVoteUp: (event) ->
		$.amaran content: {'title': 'Your vote', 'message': 'You have recently rated this card', 'info': "#{@props.votes} Votes", 'icon': 'fa fa-thumbs-o-up'}, theme: 'awesome ok', delay: 10000
	handleClickVoteDown: (event) ->
		$.amaran content: {'title': 'Your vote', 'message': 'You have recently rated this card', 'info': "#{@props.votes} Votes", 'icon': 'fa fa-thumbs-o-down'}, theme: 'awesome error', delay: 10000
	handleClick: (event) ->
		document.getElementById('explanation-card').style.display = 'block'
		document.getElementById('run-card').style.display = 'none'
		document.getElementById('back-card').style.display = 'inline-block'
		if ($('.this-ans').length > 0)
			$('.this-ans').addClass "right-color"
		if ($('.this-ansn').length > 0)
			$('.this-ansn').addClass "wrong-color"
		selected = $('input[name=option]:checked').map(-> @id).get()
		if ($('.this-ans').length > 0 and $('input[name=option]:checked').length > 0)
	 		$.amaran content: {'title': 'Congratulations!','message': 'You ran a card!', 'info':'You got 2 points more', 'icon':'fa fa-flag'}, theme: 'awesome blue', delay :10000          		
		$.ajax
	      url: '/run_question'
	      type: 'POST'
	      data: checkbox: selected, card_id: @props.card_id
      	console.log ("This is selected: "+selected) 
      	 $("input").prop('disabled', true)    
  	componentDidMount: ->
  		$(@refs.mode).addClass('animated fadeInUp')		
	nextQuestionClicked: (event) ->
		$.ajax
			url: @props.run_cards_path
			type: 'post'
		$(document).ajaxStop ->
  			setTimeout location.reload(), 5000
	flagButtonCardClicked: (event)->
		 $("#my_popup_flag").popup()  			
	render: ->	
		if(@props.votes > 0)
			rateColor = "rate-green"
		if(@props.votes < 0)
			rateColor = "rate-red"
		if(@props.votes > 1 or @props.votes < -1)
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
										onClick: @flagButtonCardClicked,
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
										onClick: @handleClick,
										ref: "runCard",
										"RUN"
								dom.div
									className: "small-12 columns text-right",
									dom.a 
										id: "back-card",
										onClick: @nextQuestionClicked,
										style: {display: 'none'},
										className: "button large radius-10",
										"NEXT",
						dom.div	
							className: "large-4 columns",	
							dom.div
								className: "small-12 columns",
								dom.span 
									dom.div
										className: "large-8 large-centered columns infinite"
										ref: "anim2",
										dom.img
											src: @props.img
									dom.div
										ref: "mode",
										className: "text-center spde-mode",																			
										dom.h2 																					
											className: "spde-mode",
											streakRemains,
										dom.div
											className: "spde-mode-title",
											msgSPDE,								
								
@RunCardAnswer = React.createClass
	displayName: 'RunCardAnswer'
	componentDidMount: ->
		$(@refs.optionToSelect).addClass('animated fadeInUp')
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


