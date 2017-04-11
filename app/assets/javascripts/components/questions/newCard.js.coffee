dom = React.DOM 	

@NewCard = React.createClass
	displayName: 'NewCard'
	getInitialState: ->
		name: 'New Card'
	getDefaultProps: ->
		url: '/questions'
	componentDidMount: ->
		$(@refs.tagsInput).autocomplete source: initTagInput
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
							"CREATE A CARD"
						dom.p {},
							"Gain more CARDS by creating CARDS!"
					dom.div
						className: "row white-background"
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
										id: "question_title",
										type: "text"
										placeholder: "CARD Tilte",
										name: "question[title]",
									dom.label {},
										"DESCRIPTION"
									dom.textarea
										id: "description",
										name: "question[description_markdown]",
									dom.div 
										className: "margin-20",
										dom.label {},
											"ANSWERS"
										dom.div
											className: "nested-fields",
											dom.div
												className: "row",
												dom.div
													className: "large-8 columns",
													dom.input
														type: "text",
														id: "question_answers_attributes_0_answer_markdown",
														name: "question[answers_attributes][0][answer_markdown]",
												dom.div
													className: "large-4 columns"
													dom.select 
														name: "question[answers_attributes][0][is_correct]",
														dom.option
															value: "0",															
															"Incorrect",
														dom.option
															value: "1",
															id: "question_answers_attributes_0_is_correct",
															"Correct",
												dom.input
													type: "hidden",
													id: "question_answers_attributes_0_answer_markdown",
													name: "question[answers_attributes][0][_destroy]",
													value: "false",
										dom.div
											className: "nested-fields",
											dom.div
												className: "row",
												dom.div
													className: "large-8 columns",
													dom.input
														type: "text",
														id: "question_answers_attributes_1_answer_markdown",
														name: "question[answers_attributes][1][answer_markdown]",
												dom.div
													className: "large-4 columns"
													dom.select
														name: "question[answers_attributes][1][is_correct]",
														dom.option
															value: "false",
															"Incorrect",
														dom.option
															value: "true",
															id: "question_answers_attributes_1_is_correct",
															"Correct",
												dom.input
													type: "hidden",
													id: "question_answers_attributes_1_answer_markdown",
													name: "question[answers_attributes][1][_destroy]",
													value: "false",
										dom.div
											className: "nested-fields",
											dom.div
												className: "row",
												dom.div
													className: "large-8 columns",
													dom.input
														type: "text",
														id: "question_answers_attributes_2_answer_markdown",
														name: "question[answers_attributes][2][answer_markdown]",
												dom.div
													className: "large-4 columns"
													dom.select 
														name: "question[answers_attributes][2][is_correct]",
														dom.option
															value: "false",
															"Incorrect",
														dom.option
															value: "true",
															id: "question_answers_attributes_2_is_correct",
															"Correct",
												dom.input
													type: "hidden",
													id: "question_answers_attributes_2_answer_markdown",
													name: "question[answers_attributes][2][_destroy]",
													value: "false",												
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
											ref: "tagsInput",
									dom.input
										className: "button large green-btn",
										type: "submit",
										name: "commit",
										value: "SUBMIT",
						dom.div
							className: "large-4 columns"	
						Components.NewCard = @NewCard

