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
						className: "row lightblue-box margin-auto"
						dom.h4 {},
							"CREATED CARDS"
						dom.p {},
							"Manage your questions: review rating, edit, delete and read comments"
					dom.div
						className: "row white-background",
						dom.div
							className: "small-4 columns",
							React.createElement SearchCard, questions_path: @props.questions_path
						dom.div
							className: "small-8 columns",			
							for card in @props.question
								React.createElement Card, key: card.id, card: card	

@Card = React.createClass
	displayName: 'Card'
	render: ->
		dom.div 
			className: "answer-container",
			dom.div
				className: "row",
				dom.div 
					className: "small-9 columns",
					dom.h5
						style: {color: "#07C", fontWeight: "bold"},
						@props.card.title	
				dom.div
					className: "small-3 text-right columns",
					dom.a
						className: "button small hollow secondary",
						href: "/questions/#{@props.card.id}",
						"review",
			dom.div
				dangerouslySetInnerHTML: __html: @props.card.description_markdown.toString()

@SearchCard = React.createClass
	displayName: 'SearchCard'
	render: ->
		dom.div
			className: "small-12 columns",
			dom.form
				action: @props.questions_path,
				method: 'get',
				acceptCharset: "UTF-8",
				dom.input
					name: "utf8",
					type: "hidden",
					value: "✓",
				dom.p {}
					dom.label
						className: "weight",
						"YOUR TOPICS",      
					dom.input
						name: "query",
						id:  "query",
						type: "text",
						placeholder: "Start typing to search more",
					dom.input
						className: "button large radius-10",
						type: "submit",
						value: "Search",
						'data-disable-with': "Search",	
