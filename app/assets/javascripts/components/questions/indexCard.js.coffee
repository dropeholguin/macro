dom = React.DOM 	

@IndexCard = React.createClass
	displayName: 'IndexCard'
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row",
				dom.div
					className: "small-12 text-center",			
					for card in @props.question
						React.createElement Card, key: card.id, card: card	

@Card = React.createClass
	displayName: 'Card'
	render: ->
		dom.div 
			className: "answer-container",
			dom.div {},
				@props.card.title	
			dom.div 
				 dangerouslySetInnerHTML: __html: @props.card.description_markdown.toString()	
