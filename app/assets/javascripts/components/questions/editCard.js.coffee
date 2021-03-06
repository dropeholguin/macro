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
										value: "patch",
									dom.div
										className: "row"
										dom.div
											className: "small-9 columns"									
											dom.label 												
												"TITLE"	
									dom.div
										className: "row"
										dom.div
											className: "small-8 columns"											
											dom.input
												id: "question_title",
												type: "text"
												placeholder: "CARD Tilte",
												name: "question[title]",
												defaultValue: @state.title,
											dom.label {},
												"DESCRIPTION"
										dom.div
											className: "small-4 columns"
											dom.select 
												ref: "choiceSelected",
												id: "choice"
												name: "choice",
												onChange: @selectOptionOnChange,
												dom.option
													value: "multiple",															
													"Multiple choice",
												dom.option
													value: "user input",															
													"User Input",	
									dom.textarea
										id: "description",
										name: "question[description_markdown]",
										@state.description	
									dom.div 
										ref: "multipleChoice",
										className: "margin-20",
										dom.div
											className: "row"
											dom.div
												className: "small-9 columns"									
												dom.label 												
													"ANSWERS"
										if @props.choice == "multiple" or @props.choice == "simple"
											for answer in @props.answers
												React.createElement AnswerMultipleChoice, key: answer.id, answer: answer		
										dom.div	
											ref: "addOther"	
											className: "nested-fields",											
											dom.a
												'data-association-insertion-template': "<div class='nested-fields'>
													<div class='row'>
														<div class='large-8 columns'>
															<input type='text' name='question[answers_attributes][new_answers][answer_markdown]' id='question_answers_attributes_new_answers_answer_markdown' />
														</div>
														<div class='large-4 columns'>
															<select name='question[answers_attributes][new_answers][is_correct]'>
																<option value='true' id='question_answers_attributes_new_answers_is_correct'>
																	Correct
																</option>
																<option value='false'>
																	Incorrect
																</option>
															</select>
														</div>
														<input type='hidden' name='question[answers_attributes][new_answers][_destroy]' id='question_answers_attributes_new_answers__destroy' value='false' /><div class='margin-15'><a class='remove_fields dynamic button small alert radius-10' href='#'>Remove</a></div>
													</div>
												</div>",
												href: "#",
												'data-association':"answer",
												'data-associations':"answers",
												className: "add_fields",
												'ADD "OTHER"'								
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
										'data-remote': true
						dom.div
							className: "large-4 columns"	
