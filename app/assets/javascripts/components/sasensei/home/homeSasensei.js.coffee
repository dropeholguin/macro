dom = React.DOM 

@HomeSasensei = React.createClass
	displayName: 'HomeSasensei'
	getDefaultProps: ->
		buttons: [{title: "cards", kanjis:"質問", subtitle: "Pick a topic and see the questions, answers and explanations.", path: "/cards_run_filter"},
		{title: "sessions", kanjis: "試験", subtitle: "Put your knowledge to test with a timed session.", path: "/sessions"},
		{title: "submit", kanjis: "支給", subtitle: "Set questions for other users and collect reputation points.", path: "/questions/new"}]
	render: ->
		dom.div
			className: "root"
			dom.div
				className: "row"
				dom.div
					className: "large-11 large-centered columns"
					dom.div
						className: "text-center margin-top-40 uppercase sasensei-title"
						"Welcome To"	
					dom.div 
						className: "logo-container margin-top-40"
						dom.a
							href: "/"
							className: "logo"
					dom.div 
						className: "text-center uppercase sasensei-title margin-top-40"
						"Enter the dojo, beat your opponents, and boost your career"
					dom.div
						className: "row margin-top-40"
						dom.div
							className: "large-12 medium-5 medium-centered small-9 small-centered large-centered columns"
							dom.div 
								className: "row"								
								for button in @props.buttons
									React.createElement ButtonMenu, key: button.id, button: button

@ButtonMenu = React.createClass
	displayName: 'ButtonMenu'
	render: ->
		dom.a
			className: "button-menu large-4 columns text-left"
			href: @props.button.path
			dom.div 
				className: "row menu-vertical-center"
				dom.div 
					className: "large-4 columns kanjis-text text-center",				
					@props.button.kanjis
				dom.div
					className: "large-8 columns"
					dom.div
						className: "menu-title uppercase"
						@props.button.title
					dom.div
						className: "menu-subtitle"
						@props.button.subtitle
	
