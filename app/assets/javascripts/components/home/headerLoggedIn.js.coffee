dom = React.DOM

@HeaderLoggedIn = React.createClass
	displayName: 'HeaderLoggedIn'
	getInitialState: ->
		points: @props.points
		current_points: []
	getDefaultProps: ->
		points: 0
	componentDidMount: ->
		$(document).foundation()
		if(@props.points == null)
			@setState(
				points: 0 
			)		
  	pointsChanged: (event) ->
  		@state.points = event.target.value
  		@forceUpdate()
	runCardClicked: (event) ->
		if @state.points == 0
	 		$.amaran content: {'title': 'Sorry!','message': 'You dont have enough tokens to run a card!', 'info':'!', 'icon':'fa fa-flag'}, theme: 'awesome error', delay :10000          		
		else
	 		$.amaran content: {'title': 'News!','message': 'You have spent 2 tokens to run a card!', 'info':"", 'icon':'fa fa-flag'}, theme: 'awesome ok', delay :10000          		
	render: ->
		dom.div
			className: "root",
			dom.div
				id: "responsive-header-logged-in",
				className: "title-bar menu-logged",
				'data-responsive-toggle': "header-logged-in",
				'data-hide-for': "medium",
				dom.button
					className: "menu-icon",
					type: "button",
					'data-toggle' : "header-logged-in",
					ref: "dropdownToggle",
				dom.div
					className: "title-bar-title",
					"Menu",
			dom.div
				id: "header-logged-in",
				className: "top-bar menu-logged padding-0",
				dom.div
					className: "top-bar-left",
					dom.ul
						className: "dropdown menu",
						'data-dropdown-menu': "",
						dom.li 
							className: "menu-item-bar",
							dom.h3 {},
								"MACRO CARDS",													
				dom.div
					className: "top-bar-right",
					dom.ul
						className: "dropdown menu",
						'data-dropdown-menu': "",
						dom.li 
							className: "menu-item-bar",
							dom.a 
								className: "radius-10",
								"Cards"	
							dom.ul
								className: "menu vertical item-white",
								dom.li {},
									dom.a
										href: "/questions/new",
										dom.i
											className: "fa fa-plus",
											'aria-hidden': "true",
											"New Card",
								dom.li {},
									dom.a
										href: "/questions",
										dom.i
											className: "fa fa-eye",
											'aria-hidden': "true",
											"Show Cards",
								dom.li {},
									dom.a
										href: "/run_cards",
										dom.i
											className: "fa fa-eye",
											onClick: @runCardClicked,
											'aria-hidden': "true",
											"Run Card",
						dom.li 
							className: "menu-item-bar",
							dom.a 
								className: "radius-10 card-mode-btn",
								onChange: @pointsChanged,
								"#{@state.points} TOKENS"
						dom.li {},
							dom.a
								href: "#",
								dom.i
									className: "fa fa-cog fa-2x",
									'aria-hidden': "true",
							dom.ul
								className: "menu vertical",
								dom.li {},
									dom.a
										'data-method': "delete",
										rel: "nofollow",
										href: @props.sign_out,
										ref: "signOut",
										dom.i
											className: "fa fa-sign-out",
											'aria-hidden': "true",
											"Log Out"



