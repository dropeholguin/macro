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
							dom.div
								className: "row",	
								React.createElement SearchCard, questions_path: @props.questions_path,
							dom.div
								className: "row",
								React.createElement SearchByTag, tag_path: @props.tag_path,
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
						"Run",
			dom.div
				dangerouslySetInnerHTML: __html: @props.card.description_markdown.toString()

@SearchCard = React.createClass
	displayName: 'SearchCard'
	componentDidMount: ->
		$(@refs.autoComplete).autocomplete source: $('#title_autocomplete').data('autocomplete-source')
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
						"SEARCH BY TITLE",      
					dom.input
						name: "query",
						id:  "title_autocomplete",
						ref: "autoComplete",
						'data-autocomplete-source': @props.questions_path,
						autoComplete: "off",
						className: "ui-autocomplete-input",
						type: "text",
						placeholder: "Start typing to search more",
					dom.input
						className: "button large radius-10",
						type: "submit",
						value: "Search",
						'data-disable-with': "Search",	

@SearchByTag = React.createClass

	render: ->
		dom.div
			className: "small-12 columns",
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag",
					"Platform Administrator",
				dom.li 
					className: "title-li",
					dom.a
						className: "tag-decoration",
						"SAS Management Console"
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag",
					"ETL Developer",
				dom.li 
					className: "title-li",
					dom.a
						className: "tag-decoration",
						"SAS Macro"
				dom.li 
					className: "title-li",
					dom.a
						className: "tag-decoration",
						"DI Studio"
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag",
					"Analyst",
				dom.li 
					className: "title-li",
					dom.a
						className: "tag-decoration",
						"SAS Programming"
				dom.li 
					className: "title-li",
					dom.a
						className: "tag-decoration",
						"Enterprise Guide"
				dom.li 
					className: "title-li",
					dom.a
						className: "tag-decoration",
						"Workspace Management"

