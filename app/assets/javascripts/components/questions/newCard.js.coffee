dom = React.DOM 	

@NewCard = React.createClass
	displayName: 'NewCard'
	getDefaultProps: ->
		url: '/questions'
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
							"CREATE A CARD"
						dom.p {},
							"Gain more CARDS by creating CARDS!"
					dom.div
						className: "row"
						dom.div
							className: "large-8 columns"
							dom.div
								id: "card-container"
								dom.form 
									method: 'POST',
									action: @props.url,
									dom.input
										key: "utf8"
										name: "utf8"
										type: "hidden"
										value: "✓"
									dom.input({
										key: "authenticity_token"
										name: "authenticity_token"
										type: "hidden"
										value: @props.csrfToken
										});		
									dom.label {},
										"TITLE"
									dom.input
										type: "text"
										placeholder: "CARD Tilte",
									dom.label {},
										"DESCRIPTION"
									dom.input
										id: "question_description_markdown_trix_input_question",
										type: "hidden",
										name: "question[description_markdown]",
										value: "Description",
									React.createElement('trix-editor', input: "question_description_markdown_trix_input_question"),
									dom.label {},
										"EXPLANATION"
									dom.input
										id: "question_explanation_markdown_trix_input_question",
										type: "hidden",
										name: "question[explanation_markdown]",
										value: "Explanation of correct answers",
									React.createElement('trix-editor', input: "question_explanation_markdown_trix_input_question"),
									dom.input
										className: "button large green-btn",
										type: "submit",
										name: "commit",
										value: "SUBMIT",
						dom.div
							className: "large-4 columns"	
		

				

