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
					dom.table {},
						dom.thead {},
								dom.th {},
									"Title",
								dom.th {},
									"Description",
							dom.tbody {},
								for card in @props.question
									React.createElement Card, key: card.id, card: card	

@Card = React.createClass
	render: ->
		dom.tr {},
			dom.td {},
				@props.card.title	
			dom.td {},
				dangerouslySetInnerHTML: __html: @props.card.description_markdown.toString()		
