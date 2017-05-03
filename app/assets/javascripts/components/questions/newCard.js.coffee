dom = React.DOM 	

@NewCard = React.createClass
	displayName: 'NewCard'
	getInitialState: ->
		name: 'New Card'
	getDefaultProps: ->
		url: '/questions'
	componentDidMount: ->
		$(@refs.tagsInput).autocomplete source: initTagInput
		$(document).ready initTagInput
		$(document).on 'page:load', initTagInput		
	tutoForTitleClicked: (event) ->
		$(@refs.descriptionTuto).hide()
		$(@refs.answerTuto).hide()
		$(@refs.explanationTuto).hide()
		$(@refs.titleTuto).show()
		$(@refs.titleTuto).addClass('animated fadeInDown')
	tutoForDescriptionClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.answerTuto).hide()
		$(@refs.explanationTuto).hide()
		$(@refs.descriptionTuto).show()
		$(@refs.descriptionTuto).addClass('animated fadeInDown')
	tutoForExplanationClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.descriptionTuto).hide()
		$(@refs.answerTuto).hide()
		$(@refs.explanationTuto).show()
		$(@refs.explanationTuto).addClass('animated fadeInDown')
	tutoForAnswerClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.descriptionTuto).hide()
		$(@refs.explanationTuto).hide()
		$(@refs.answerTuto).show()
		$(@refs.answerTuto).addClass('animated fadeInDown')		
	tutoForTagClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.descriptionTuto).hide()
		$(@refs.explanationTuto).hide()				
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
									dom.div
										className: "row"
										dom.div
											className: "small-8 columns"
											dom.input
												id: "question_title",
												type: "text"
												placeholder: "CARD Tilte",
												name: "question[title]",
												onClick: @tutoForTitleClicked,
												required: true
										dom.div
											className: "small-4 columns"
											dom.select 
												name: "options",
												dom.option
													value: "0",															
													"Single Choice",
												dom.option
													value: "1",															
													"Multiple Choice",
												dom.option
													value: "2",															
													"Open CARD",										
									dom.label 
										onClick: @tutoForDescriptionClicked,
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
														onClick: @tutoForAnswerClicked
														type: "text",
														required: true,
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
														required: true,
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
														required: true,		
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
										dom.div		
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
									dom.label 
										onClick: @tutoForExplanationClicked,
										"EXPLANATION"
									dom.textarea
										id: "explanation",
										name: "question[explanation_markdown]",
									dom.div 
										className: "margin-20",
										dom.label 
											onClick: @tutoForTagClicked,
											"TOPICS"																						
										dom.input
											'data-delimiter': ", ",
											multiple: "true",
											name: "question[tag_list][]",
											id: "question_tag_list",
											className: "tagsinput",
											ref: "tagsInput",		
											required: true,									
									dom.input
										className: "button large green-btn",
										type: "submit",
										name: "commit",
										value: "SUBMIT",
										ref: "submit"
						dom.div
							className: "large-4 columns"
							dom.div
								style: {minHeight: "112px"},
								dom.div 
									ref: "titleTuto",
									style: {display: "none"}
									className: "tutorial-container",
									dom.h5 
										className: "bold",
										"How to create CARDS?",
									dom.h6
										className: "bold",
										"Is your question about SAS?",
									dom.p {},	
										"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus sapien nunc eget."
							dom.div
								style: {minHeight: "457px"},
								dom.div 
									ref: "descriptionTuto",
									style: {display: "none"}
									className: "tutorial-container",
									dom.h5 
										className: "bold",
										"How to Format",
									dom.h6
										className: "bold",
										"Markdown only"
									dom.div {},	
										"• put returns between paragraphs"
									dom.div {},	
										"• for linebreak add 2 spaces at end"
									dom.div {},	
										"•  _italic_ or **bold**"
									dom.div {},	
										"• for linebreak add 2 spaces at end"
									dom.div {},
										"• indent code by 4 spaces" 
									dom.div {},
										"• backtick escapes `like _so_`" 
									dom.div {},
										"• quote by placing > at start of line" 
									dom.div {},
										"• to make links" 
									dom.div {},
										"• <http://foo.com>" 
									dom.div {},
										"• [foo](http://foo.com)"
							dom.div
								style: {minHeight: "236px"},
								dom.div 
									ref: "answerTuto",
									style: {display: "none"}
									className: "tutorial-container",
									dom.h5 
										className: "bold",
										"Possible Answers",
									dom.h6
										className: "bold",
										"Be precise"
									dom.div {},	
										"• For multiple choices questions there must be only 1 correct answer."
									dom.div {},	
										"• Avoid doublemeaning"
									dom.div {},	
										"•  Recheck answers after typing"
							dom.div 
								ref: "explanationTuto",
								style: {display: "none"}
								className: "tutorial-container",
								dom.h5 
									className: "bold",
									"Explain clearly",
								dom.h6
									className: "bold",
									"Every answer counts"
								dom.div {},	
									"• Refer to the answer by typing 1, 2, 3 etc."
								dom.div {},	
									"• Explain every thing in detail."
								dom.div {},	
									"•  Be cool!"
							dom.div 
								ref: "tagsTuto",
								style: {display: "none"}
								className: "tutorial-container",
								dom.h5 
									className: "bold",
									"Explain clearly",
								dom.h6
									className: "bold",
									"Every answer counts"
								dom.div {},	
									"• Refer to the answer by typing 1, 2, 3 etc."
								dom.div {},	
									"• Explain every thing in detail."
								dom.div {},	
									"•  Be cool!"
						Components.NewCard = @NewCard

