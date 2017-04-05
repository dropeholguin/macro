dom = React.DOM 

@ShowCard = React.createClass

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
							"RUN A CARD"
						dom.p {},
							"Choose a topic, take questions one by one and get bonuses for 4 in a row."
					
					dom.div
						className: "row white-background",
						dom.div
							className: "answer-container large-8 large-centered columns"
							dom.h4
								className: "weight",
								style: {color: "#07C", fontWeight: "bold"},
								@props.title,
							dom.div
								dangerouslySetInnerHTML: __html: @props.description.toString(),
							dom.div
								className: "row",
								dom.div 
									className: "small-6 columns",
									dom.img
										className: "thumbnail", 
										src: "/assets/submit.png",
								dom.div 
									className: "small-6 columns",
									dom.h5
										className: "weight",
										"Answers:"
									for answer in @props.answers
										React.createElement CardAnswer, key: answer.id, answer: answer, choice: @props.choice
							dom.div
								className: "row",
								dom.div
									className: "small-8 columns",
									for tag in @props.tag_list
										React.createElement TagList, key: tag.id, tag: tag,									
								dom.div
									className: "small-4 columns text-right",
									dom.a 
										className: "button large radius-10",
										href: "#",	
										"RUN"

@CardAnswer = React.createClass

	render: ->
		if(@props.choice == "simple")
			typeOption = "radio"
		else if(@props.choice == "multiple")
			typeOption = "checkbox"
		dom.div 
			className: "root margin-15",
			dom.div
				className: "row",							
				dom.div 
					className: "small-12 columns",
					dom.input
						id: "option#{@props.answer.id}",
						name: "option",
						type: typeOption,	
					dom.label
						htmlFor: "option#{@props.answer.id}",
						@props.answer.answer_markdown					
			
@TagList = React.createClass

	render: ->			
		dom.li 
			className: "margin-tag title-li tag-horizontal",
			dom.a
				className: "tag-decoration",
				@props.tag


