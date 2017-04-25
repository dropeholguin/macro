dom = React.DOM 	

@EditCard = React.createClass
	displayName: 'EditCard'
	getInitialState: ->
		name: 'New Card'
		title:  @props.title
		description: @props.description
		explanation: @props.explanation
		tag_list: @props.tag_list 
	getDefaultProps: ->
		url: '/questions'
	componentDidMount: ->
		$(@refs.tagsInputEdit).autocomplete source: initTagInput
		$(document).ready initTagInput
		$(document).on 'page:load', initTagInput
	handleChangeOptions: (event) ->
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
							"EDIT A CARD"
					dom.div
						className: "row white-background"
						dom.div
							className: "large-8 columns"
							dom.div
								id: "card-container"
								dom.form 
									className: "edit_question",
									id: "edit_question_#{@props.card_id}",	
									method: 'post',
									action: "/questions/#{@props.card_id}",
									acceptCharset: "UTF-8",
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
									dom.input
										name: "_method",
										type: "hidden",
										method: "patch",
									dom.label {},
										"TITLE"
									dom.input
										id: "question_title",
										type: "text"
										placeholder: "CARD Tilte",
										name: "question[title]",
										value: @state.title,
									dom.label {},
										"DESCRIPTION"
									dom.textarea
										id: "description",
										name: "question[description_markdown]",
										@state.description									
									dom.label {},
										"EXPLANATION"
									dom.textarea
										id: "explanation",
										name: "question[explanation_markdown]",
										@state.explanation
									dom.div 
										className: "margin-20",
										dom.label {},
											"TOPICS"
										dom.input
											'data-delimiter': ", ",
											multiple: "true",
											name: "question[tag_list][]",
											id: "question_tag_list",
											className: "tagsinput",
											ref: "tagsInputEdit",
											value: @state.tag_list
									dom.input
										className: "button large green-btn",
										type: "submit",
										name: "commit",
										value: "CONTINUE",
										'data-disable-with': "CONTINUE",
						dom.div
							className: "large-4 columns"	