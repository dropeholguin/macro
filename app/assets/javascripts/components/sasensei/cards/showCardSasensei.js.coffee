dom = React.DOM 

@ShowCardSasensei = React.createClass
	render:->
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "question-background"
						dom.div
							style:	{fontSize: "16px"}
							className: "large-8 large-centered columns"
							dangerouslySetInnerHTML: __html: @props.description.toString(),
					dom.div
						className: "answers"
						for answer in @props.answers
							React.createElement CardAnswerSasensei, key: answer.id, answer: answer, choice: @props.card.choice

@CardAnswerSasensei = React.createClass
	displayName: 'CardAnswerSasensei'
	componentDidMount: ->
	render: ->
		if(@props.choice == "simple")
			typeOption = "radio"
		else if(@props.choice == "multiple")
			typeOption = "checkbox"
		else if (@props.choice == "user input")
			typeOption = "text"
			hide = "none"
			msg = "type your answer"
		if(@props.answer.is_correct)
			rightColor = "this-ans" 
		else
			rightColor = "this-ansn"
		dom.div
			className: "answer_field",	
			dom.input
				id: "#{@props.answer.id}",
				name: "option",
				type: typeOption,
				placeholder: msg
			dom.label
				style: {display: hide}
				className: "uppercase menu-title "+rightColor
				htmlFor: "#{@props.answer.id}",
				dangerouslySetInnerHTML: __html: @props.answer.answer_markdown.toString()
