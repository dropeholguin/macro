dom = React.DOM 

@FlagForm = React.createClass
	displayName: 'FlagForm'
	componentDidMount: ->
		simplemde = new SimpleMDE(element: $(@refs.textFlag)[0])
	render: ->
		dom.div
			className: "root",
			dom.div
				id: "my_popup"	
				style: {display: "none", background: "#ffffff", padding: "15px", borderRadius: "10px"}
				dom.form 
					action: "/flags",
					method: "post",
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
					dom.div
						className: "field space",
						dom.label
							htmlFor: "reason",
							"Reason:",
						dom.textarea
							ref: " textFlag",
							name: "reason",
							id: " reason",
						dom.input
							type: "hidden",
							id: "question_id",
							name: "question_id",
							value: @props.card_id,
					dom.div
						className: "actions text-center",
						dom.input
							id: "flag_form_input",
							className: "button radius-10",
							type: "submit",
							name: "commit",
							value: "Send",
							'data-disable-with': "Send"

