dom = React.DOM 

@ShowCard = React.createClass

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
							dom.h5
								className: "weight",
								"Answers"
							for answer in @props.answers
								React.createElement CardAnswer, key: answer.id, answer: answer, choice: @props.choice

@CardAnswer = React.createClass

	render: ->
		if(@props.choice == "simple")
			typeOption = "radio"
		else if(@props.choice == "multiple")
			typeOption = "checkbox"
		dom.div 
			className: "root margin-15",
			dom.div
				className: "row",							
				dom.div 
					className: "small-5 columns",
					dom.input
						type: typeOption,						
					dom.p
						@props.answer.answer_markdown					
			


