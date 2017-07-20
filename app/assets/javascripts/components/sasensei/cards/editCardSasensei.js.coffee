dom = React.DOM 	

@EditCardSasensei = React.createClass
	displayName: 'EditCard'
	getInitialState: ->
		name: 'Edit Card'
		columns: "large-8"
		title:  @props.title
		description: @props.description
		explanation: @props.explanation
		tag_list: @props.tag_list 
	getDefaultProps: ->
		url: '/questions'
	componentDidMount: ->
		$(@refs.multipleChoice).show()
		$(@refs.userInput).hide()
		$(@refs.tagsInput).autocomplete source: initTagInput
		$(document).ready initTagInput
		$(document).on 'page:load', initTagInput	
		$(@refs.labelDescription).addClass('animated bounceIn')	
	tutoForTitleClicked: (event) ->
		$(@refs.descriptionTuto).hide()
		$(@refs.answerTuto).hide()
		$(@refs.explanationTuto).hide()
		$(@refs.tagsTuto).hide()
		$(@refs.titleTuto).show()
		$(@refs.answerTutoUserInput).hide()
		$(@refs.titleTuto).addClass('animated fadeInDown')
	tutoForDescriptionClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.answerTuto).hide()
		$(@refs.explanationTuto).hide()
		$(@refs.tagsTuto).hide()
		$(@refs.descriptionTuto).show()
		$(@refs.answerTutoUserInput).hide()
		$(@refs.descriptionTuto).addClass('animated fadeInDown')
	tutoForExplanationClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.descriptionTuto).hide()
		$(@refs.answerTuto).hide()
		$(@refs.tagsTuto).hide()
		$(@refs.explanationTuto).show()
		$(@refs.answerTutoUserInput).hide()
		$(@refs.explanationTuto).addClass('animated fadeInDown')
	tutoForAnswerClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.descriptionTuto).hide()
		$(@refs.explanationTuto).hide()
		$(@refs.tagsTuto).hide()
		$(@refs.answerTuto).show()
		$(@refs.answerTutoUserInput).hide()
		$(@refs.answerTuto).addClass('animated fadeInDown')		
	tutoForTagClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.descriptionTuto).hide()
		$(@refs.explanationTuto).hide()		
		$(@refs.answerTuto).hide()
		$(@refs.tagsTuto).show()
		$(@refs.answerTutoUserInput).hide()
		$(@refs.tagsTuto).addClass('animated fadeInDown')	
	selectOptionOnChange: (event) ->
		if $(@refs.choiceSelected).val() == "multiple"
			$(@refs.answer1).append('<div class="row" id="answer1"><div class="large-8 columns"><input type="text" id="question_answers_attributes_1_answer_markdown" name="question[answers_attributes][1][answer_markdown]"></div><div class="large-4 columns"><select name="question[answers_attributes][1][is_correct]"><option value="false">Incorrect</option><option value="true" id="question_answers_attributes_1_is_correct">Correct</option></select></div><input type="hidden" id="question_answers_attributes_1_answer_markdown" name="question[answers_attributes][1][_destroy]" value="false"></div>')
			$(@refs.answer2).append('<div class="row" id="answer2"><div class="large-8 columns"><input type="text" id="question_answers_attributes_2_answer_markdown" name="question[answers_attributes][2][answer_markdown]"></div><div class="large-4 columns"><select name="question[answers_attributes][2][is_correct]"><option value="false">Incorrect</option><option value="true" id="question_answers_attributes_2_is_correct">Correct</option></select></div><input type="hidden" id="question_answers_attributes_2_answer_markdown" name="question[answers_attributes][2][_destroy]" value="false"></div>')
			$(@refs.optionAnswer0).show()
			$(@refs.addOther).show()
			@setState({columns: "large-8"})
		if $(@refs.choiceSelected).val() == "user input"
			$("#answer1").remove()
			$("#answer2").remove()
			$(@refs.optionAnswer0).hide()
			$(@refs.addOther).hide()
			@setState({columns: "large-12"})
	userInputClicked: (event) ->
		$(@refs.titleTuto).hide()
		$(@refs.descriptionTuto).hide()
		$(@refs.explanationTuto).hide()		
		$(@refs.answerTuto).hide()
		$(@refs.tagsTuto).hide()
		$(@refs.answerTutoUserInput).show()
		$(@refs.answerTutoUserInput).addClass('animated fadeInDown')
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row"				
				dom.div
					className: "row"
					dom.div
						className: "large-10 large-centered columns"
						dom.div
							id: "card-new"
							dom.form 
								className: "edit_question"
								id: "edit_question_#{@props.card_id}"
								encType: "multipart/form-data"
								method: 'POST',
								action: "#{@props.url}/#{@props.card_id}"
								acceptCharset: "UTF-8"
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
										className: "large-11 large-centered medium-10 medium-centered small-11 small-centered columns question-background"								
										dom.textarea
											id: "description",
											name: "question[description_markdown]",
											placeholder: "Start typing your question..."
											@state.description
								dom.div
									className: "row"									
									dom.div
										className: "large-10 large-centered medium-10 medium-centered small-11 small-centered columns"
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
								dom.div 
									ref: "userInput",
									className: "margin-20",
									dom.div
										className: "row"
										dom.div
											className: "small-9 columns"									
											dom.label 												
												"ANSWER"
									dom.div											
										className: "row",
										dom.div
											className: "large-12 columns",
											dom.input
												type: "text",
												name: "user_input",
												id: "user_input",
												onClick: @userInputClicked,
								dom.div 
									ref: "multipleChoice",
									className: "margin-20  large-10 large-centered medium-10 medium-centered small-11 small-centered columns",
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
										className: "nested-fields text-center add-other",											
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
											'+'
								dom.div
									className: "row"
									dom.div
										className: "large-11 large-centered medium-10 medium-centered small-11 small-centered columns question-background"
										dom.textarea
											id: "explanation",
											name: "question[explanation_markdown]",
											placeholder: "Start typing your explanation..."
											@state.explanation
								dom.div 
									className: "margin-20 large-10 large-centered medium-10 medium-centered small-11 small-centered columns",																												
									dom.input
										'data-topics': "/topics",
										'data-delimiter': ", ",
										multiple: "true",
										name: "question[tag_list][]",
										id: "question_tag_list",
										className: "tagsinput",
										ref: "tagsInput",		
										required: true,	
										value: @state.tag_list
								dom.div 
									className: "text-center"								
									dom.input
										className: "button large btn-run menu-title uppercase",
										type: "submit",
										name: "commit",
										value: "SUBMIT",
										ref: "submit"

@AnswerMultipleChoice = React.createClass
	render: ->
		dom.div
			className: "nested-fields",
			dom.div
				className: "row",
				dom.div
					className: "large-8 columns",
					dom.input
						onClick: @tutoForAnswerClicked
						type: "text",
						id: "question_answers_attributes_#{@props.answer.id}_answer_markdown",
						name: "question[answers_attributes][#{@props.answer.id}][answer_markdown]",
						defaultValue: @props.answer.answer_markdown
				dom.div
					ref: "optionAnswer0"
					className: "large-4 columns"
					dom.select 
						name: "question[answers_attributes][#{@props.answer.id}][is_correct]",
						dom.option
							value: "0",															
							"Incorrect",
						dom.option
							value: "1",
							id: "question_answers_attributes_#{@props.answer.id}_is_correct",
							"Correct",
				dom.input
					type: "hidden",
					id: "question_answers_attributes_#{@props.answer.id}_answer_markdown",
					name: "question[answers_attributes][#{@props.answer.id}][_destroy]",
					value: "false",

					