import React from 'react'

import { SearchTag, SearchCards, RunCardFilterCard, ButtonExplanation } from '../cards/runCardFilter.js.coffee'

dom = React.DOM

@RunSessionFilterPage = React.createClass
	displayName: 'RunSessionFilter'
	getDefaultProps: ->
		tag_path: ''
		buttons: [{title: "pick a topic", subtitle: "sessions can be filtered for all or any topics."},
			{title: "run session", subtitle: "You are graded first on accuracy, and then on speed."},
			{title: "GAIN PRIVILEGES", subtitle: "A pass will grant the ability to SUBMIT questions.", display: "none"}]
	render: ->
		dom.div 
			className: "row bottom-60"
			dom.div
				className: "large-4 columns"
				React.createElement SearchTag, tag_path: @props.tag_path
			dom.div
				className: "large-4 columns"
				React.createElement SearchCards, path: @props.questions_path, title: "Return sessions with all these tags:"
				React.createElement SearchCards, path: @props.questions_path, title: "Return sessions with any of these tags"
				dom.div 
					className: "sasensei-title text-center uppercase"
					"Number of Sessions Available"	
				React.createElement RunCardFilterCard, number_questions: @props.number_questions, total: @props.total, run_cards_path: @props.run_cards_path
			dom.div
				className: "large-4 columns"
				for button in @props.buttons
					React.createElement ButtonExplanation, key: button.id, button: button