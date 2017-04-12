dom = React.DOM 	

@IndexCard = React.createClass
	displayName: 'IndexCard'
	render: ->
		dom.div
			className: "root",			
			dom.div
				className: "row lightblue-box margin-auto"
				dom.h4 {},
					"CREATED CARDS"
				dom.p {},
					"Manage your questions: review rating, edit, delete and read comments"
					
@Card = React.createClass
	displayName: 'Card'
	render: ->
		dom.div 
			className: "answer-container",
			dom.div
				className: "row",
				dom.div 
					className: "small-9 columns",
					dom.h5
						style: {color: "#07C", fontWeight: "bold"},
						@props.title	
				dom.div
					className: "small-3 text-right columns",
					dom.a
						className: "button small hollow secondary",
						href: "/questions/#{@props.id}",
						"Run",
			dom.div {},
				dom.div
					dangerouslySetInnerHTML: __html: @props.description.toString(),
				dom.div
					className: "row"
					dom.div
						className: "small-10 columns"
						dom.div 
							className: "margin-tag title-li tag-horizontal",
							for topic in @props.tag_list
								React.createElement Topics, key: topic.id, topic: topic, tag_path: @props.tag_path

@Topics = React.createClass
	displayName: 'Topics'
	render: ->
		if(@props.tag_path.split("?").length-1 > 0)
			url_tag = "&the_tag="
		else
			url_tag = "?&the_tag=" 
		dom.a
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
						"SEARCH BY TITLE",      
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
				
