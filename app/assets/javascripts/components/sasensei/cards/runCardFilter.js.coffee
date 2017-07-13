dom = React.DOM

@RunCardFilterPage = React.createClass
	displayName: 'RunCardFilter'
	getDefaultProps: ->
		buttons: [{title: "pick a topic", subtitle: "cards can be filtered for all or any topics."},
			{title: "run cards", subtitle: "The Stimer grants 2 minutes to conquer the question"},
			{title: "earn tokens", subtitle: "achieve 4 correct answers in a row to enter spde mode.", display: "none"}]
	render: ->
		dom.div 
			id: "run_card_filter"
			className: "row bottom-60"
			dom.div
				id: "search_run_card_filter"
				className: "large-4 columns"
				React.createElement SearchTag, tag_path: @props.tag_path
			dom.div				
				className: "large-4 columns"
				React.createElement SearchCards, path: @props.questions_path, title: "Include cards with all these tags:"
				React.createElement SearchCards, path: @props.questions_path, title: "Exclude cards with any of these tags"
				dom.div 
					className: "sasensei-title text-center uppercase"
					"Number of Cards Available"	
				React.createElement RunCardFilterCard, number_questions: @props.number_questions, total: @props.total, run_cards_path: @props.run_cards_path
			dom.div
				id: "explanation_run_card_filter"
				className: "large-4 columns"
				for button in @props.buttons
					React.createElement ButtonExplanation, key: button.id, button: button

@SearchTag = React.createClass
	displayName: 'SearchByTag'
	render: ->
		if(@props.tag_path.split("?").length-1 > 0)
			url_tag = "&the_tag="
		else
			url_tag = "?&the_tag=" 
		dom.div
			className: "small-12 columns",
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag-sasensei uppercase",
					"Platform Administrator",
				dom.li 
					className: "title-li btn-tag",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"SAS+Management+Console",
						className: "search-tag-sasensei uppercase",
						"SAS Management Console"
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag-sasensei uppercase",
					"ETL Developer",
				dom.li 
					className: "title-li btn-tag",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"SAS+Macro",
						className: "search-tag-sasensei uppercase",
						"SAS Macro"
				dom.li 
					className: "title-li btn-tag",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"DI+Studio",
						className: "search-tag-sasensei uppercase",
						"DI Studio"
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag-sasensei uppercase",
					"Analyst",
				dom.li 
					className: "title-li btn-tag",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"SAS+Programming",
						className: "search-tag-sasensei uppercase",
						"SAS Programming"
				dom.li 
					className: "title-li btn-tag",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"Enterprise+Guide",
						className: "search-tag-sasensei uppercase",
						"Enterprise Guide"
				dom.li 
					className: "title-li btn-tag",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"Workspace+Management",
						className: "search-tag-sasensei uppercase",
						"Workspace Management"



@SearchCards = React.createClass
	displayName: 'SearchCard'
	getDefaultProps:->
		align: 'center'
	componentDidMount: ->
		$(@refs.autoComplete).autocomplete source: $('#title_autocomplete').data('autocomplete-source')
	render: ->
		dom.div
			className: "small-12 columns",
			dom.form
				action: @props.path,
				method: 'get',
				acceptCharset: "UTF-8",
				dom.input
					name: "utf8",
					type: "hidden",
					value: "✓",
				dom.p {}
					dom.label
						style: {padding: @props.padding, fontSize: @props.font_size}
						className: "weight title-tag-sasensei uppercase text-#{@props.align}",
						@props.title,      
					dom.input
						style: {padding: "0 18px", fontSize: "13px"}
						name: "query",
						id:  "title_autocomplete",
						ref: "autoComplete",
						'data-autocomplete-source': @props.path,
						autoComplete: "off",
						className: "ui-autocomplete-input btn-search-tag menu-subtitle",
						type: "text",
					dom.input
						style: {display: "none"}
						className: "button large radius-10",
						type: "submit",
						value: "Search",
						'data-disable-with': "Search",

@RunCardFilterCard = React.createClass
	getDefaultProps: ->
		number_questions: 0
	getInitialState: ->
		number_questions: @props.number_questions
	componentDidMount: ->
		if @props.number_questions == null
			@setState(number_questions: 0)		
		$(@refs.arrow).addClass('animated pulse infinite')
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row radius-10",
				dom.div
					className: "large-12 columns"
					dom.h4 
						className: "sasensei-title weight number text-center"
						"#{@state.number_questions}"											
					dom.div
						className: "large-12 columns text-center",
						if @props.total > 0	
							dom.a
								style: {width: "100%"}
								className: "button btn-run menu-title uppercase",
								href: @props.run_cards_path,
								"RUN"
								
@ButtonExplanation = React.createClass
	displayName: 'ButtonExplanation'
	getInitialState: ->
		display: @props.button.display
	render: ->
		dom.div
			className: "root"
			dom.a
				style: {float: "left"}
				className: "description-field large-12 columns text-center"
				href: @props.button.path
				dom.div 
					className: "row menu-vertical-center"
					style: {minHeight: "100px"}				
					dom.div
						className: "large-12 columns"
						dom.div
							className: "menu-title uppercase"
							@props.button.title
						dom.div
							className: "menu-subtitle"
							style: {fontSize: "16px"}
							@props.button.subtitle
			dom.div
				style: {display: "#{@props.button.display}", padding: "0", fontSize: "25px", float: "left"}
				className: "title-tag-sasensei uppercase large-11 columns text-center weight"
				"V"	