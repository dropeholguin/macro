dom = React.DOM

@SessionIndex = React.createClass
	displayName: 'SessionIndex'
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "large-12 text-center columns plans",
				dom.div
					className: "session-pink-box",	
					dom.h4 {},
						@props.title
					dom.div {},
						"Pass this test and gain new privileges!",
					dom.div {}, 									 	
				dom.div
					className: "white-background radius-bottom",
					dom.div
						className: "small-6 large-10 small-centered large-centered columns img-home",
						dom.img
							src: @props.session_img,
					dom.p 
						className: "bold",
						"TOTAL CARDS: #{@props.count}"
					dom.div
						className: "row margin-20",
						dom.div
							className: "large-8 large-centered columns",
							dom.a
								href: @props.run_sessions_path,
								className: "button large radius-10 orange",
								"RUN"						
@SearchByTagSession = React.createClass
	displayName: 'SearchByTag'
	render: ->
		if(@props.tag_path.split("?").length-1 > 0)
			url_tag = "&query="
		else
			url_tag = "?&query=" 
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
						href: "#{@props.tag_path}"+url_tag+"Management+Console",
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
						href: "#{@props.tag_path}"+url_tag+"Macro",
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
						href: "#{@props.tag_path}"+url_tag+"Programming",
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

