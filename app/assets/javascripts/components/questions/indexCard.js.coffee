dom = React.DOM 	

@IndexCard = React.createClass
	displayName: 'IndexCard'
	getDefaultProps: ->
		title_page: "???  new questions available"
		description_page: "Filter by topics and keywords.  If you answer all available questions correctly then play continues at ranuni(0)"
	getInitialState: ->
		title_page: @props.title_page
		description_page: @props.description_page
	render: ->
		dom.div
			className: "root",			
			dom.div
				className: "row lightblue-box margin-auto"
				dom.h4 {},
					@state.title_page
				dom.p {},
					@state.description_page
					
@Card = React.createClass
	displayName: 'Card'
	getDefaultProps: ->
		button_1: "VIEW"
		button_2: "EDIT_D"
		button_3: "DELETE_D"
		small: "small-10 columns"
	getInitialState: ->
		button_1: @props.button_1
		button_2: @props.button_2 
		button_3: @props.button_3
	componentDidMount: ->
		highlightAllCodes()
	render: ->
		if(@state.button_2 == "EDIT_D")
			showButton = "show-hide"
		else
			showButton = "show-block"
		dom.div 
			className: "answer-container",
			dom.div
				className: "row",
				dom.div 
					className: "small-7 columns",
					dom.a 
						className: "card-hover"
						href: "/questions/#{@props.id}",
						dom.h5
							style: {color: "#07C", fontWeight: "bold"},
							@props.title	
				dom.div
					className: "small-5 text-right columns",
					dom.a
						className: "button small hollow secondary margin-side "+showButton,
						href: "/questions/#{@props.id}",
						@state.button_1,
					dom.a
						className: "button small hollow secondary margin-side "+ showButton,
						href: "/questions/#{@props.id}/edit",
						@state.button_2,
					dom.a
						className: "button small hollow secondary margin-side "+showButton,
						href: "#",
						@state.button_3,
			dom.div {},
				dom.div
					dangerouslySetInnerHTML: __html: @props.description.toString(),
				dom.div
					className: "row"
					dom.div
						className: @props.small
						dom.div 
							className: "margin-tag title-li tag-horizontal",
							style: {float: @props.float},
							for topic in @props.tag_list
								React.createElement Topics, key: topic.id, topic: topic, tag_path: @props.tag_path, display: @props.display, marginTop: @props.marginTop

@Topics = React.createClass
	displayName: 'Topics'
	render: ->
		if(@props.tag_path.split("?").length-1 > 0)
			url_tag = "&the_tag="
		else
			url_tag = "?&the_tag=" 
		dom.a
			style: {display: @props.display, marginTop: @props.marginTop},
			href: "#{@props.tag_path}"+url_tag+@props.topic,
			className: "tag-decoration",
			@props.topic			

@SearchCard = React.createClass
	displayName: 'SearchCard'
	componentDidMount: ->
		$(@refs.autoComplete).autocomplete source: $('#title_autocomplete').data('autocomplete-source')
	render: ->
		dom.div
			className: "small-12 columns",
			dom.form
				action: @props.questions_path,
				method: 'get',
				acceptCharset: "UTF-8",
				dom.input
					name: "utf8",
					type: "hidden",
					value: "✓",
				dom.p {}
					dom.label
						className: "weight",
						"SEARCH A CARD",      
					dom.input
						name: "query",
						id:  "title_autocomplete",
						ref: "autoComplete",
						'data-autocomplete-source': @props.questions_path,
						autoComplete: "off",
						className: "ui-autocomplete-input",
						type: "text",
						placeholder: "Start typing to search more",
					dom.input
						className: "button large radius-10",
						type: "submit",
						value: "Search",
						'data-disable-with': "Search",

@SearchByTag = React.createClass
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
					className: "title-tag",
					"Platform Administrator",
				dom.li 
					className: "title-li",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"SAS+Management+Console",
						className: "tag-decoration",
						"SAS Management Console"
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag",
					"ETL Developer",
				dom.li 
					className: "title-li",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"SAS+Macro",
						className: "tag-decoration",
						"SAS Macro"
				dom.li 
					className: "title-li",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"DI+Studio",
						className: "tag-decoration",
						"DI Studio"
			dom.div 
				className: "margin-tag",
				dom.span
					className: "title-tag",
					"Analyst",
				dom.li 
					className: "title-li",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"SAS+Programming",
						className: "tag-decoration",
						"SAS Programming"
				dom.li 
					className: "title-li",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"Enterprise+Guide",
						className: "tag-decoration",
						"Enterprise Guide"
				dom.li 
					className: "title-li",
					dom.a
						href: "#{@props.tag_path}"+url_tag+"Workspace+Management",
						className: "tag-decoration",
						"Workspace Management"
				
