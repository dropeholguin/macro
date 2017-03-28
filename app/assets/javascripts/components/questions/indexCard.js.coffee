dom = React.DOM 	

@IndexCard = React.createClass
	displayName: 'IndexCard'
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "row lightblue-box"
						dom.h4 {},
							"CREATED CARDS"
						dom.p {},
							"Manage your questions: review rating, edit, delete and read comments"
					dom.div
						className: "row",
						dom.div
							className: "small-4 columns",
							dom.label
								className: "weight",
								"YOUR TOPICS",
							dom.input
								type: "text",
								placeholder: "Start typing to search more",
						dom.div
							className: "small-8 columns",			
							for card in @props.question
								React.createElement Card, key: card.id, card: card	

@Card = React.createClass
	displayName: 'Card'
	render: ->
		dom.div 
			className: "answer-container",
			dom.div {},
				dom.h5
					style: {color: "#07C", fontWeight: "bold"},
					@props.card.title	
			dom.div
				dangerouslySetInnerHTML: __html: @props.card.description_markdown.toString()	
