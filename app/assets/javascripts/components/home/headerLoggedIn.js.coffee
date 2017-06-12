dom = React.DOM

@HeaderLoggedIn = React.createClass
	displayName: 'HeaderLoggedIn'
	getInitialState: ->
		points: @props.points
		current_points: []
		notifications: []
	getDefaultProps: ->
		points: 0
	componentDidMount: ->
		$(document).foundation()
		if(@props.points == null)
			@setState(
				points: 0 
			)
	componentWillMount: ->
		@fetchPoints()
		setInterval(@fetchPoints, 1000)
	fetchPoints: ->
		$.ajax
		  url: @props.tokens_wallet_path
		  type: 'post'
		  dataType: 'json'
		  data: points: @state.points
		  success: (data) =>
		    @setState({points: data.tokens, total_notifications: data.number_notifications, notifications: data.notifications})
		    if @state.total_notifications == 0
		    	@setState({hide_number: "none"})
	    	else
	    		@setState({hide_number: "block"})
		    console.log data		

	runCardClicked: (event) ->
		if @state.points == 0
	 		$.amaran content: {'title': 'Sorry!','message': 'You dont have enough tokens to run a card!', 'info':'!', 'icon':'fa fa-flag'}, theme: 'awesome error', delay :10000          		
		else
	 		$.amaran content: {'title': 'News!','message': 'You have spent 2 tokens to run a card!', 'info':"", 'icon':'fa fa-flag'}, theme: 'awesome ok', delay :10000          		
	notificationClicked: (event) ->
		$("#notificationContainer").fadeToggle(300);
		$("#notification_counter").fadeOut("slow");
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
							id: "logo",
							style: {maxWidth: "180px"},
							className: "menu-item-bar"
							dom.a
								href: @props.root_path,		
								dom.img
									src: @props.img,						
				dom.div
					className: "top-bar-right",
					dom.ul
						className: "dropdown menu",
						'data-dropdown-menu': "",
						dom.li 
							onClick: @notificationClicked,
							className: "item-selected",
							id: "notification_li",
							dom.span
								style: {display: @state.hide_number}
								id: "notification_counter",
								@state.total_notifications,
							dom.i
								className: "fa fa-bell-o fa-2x",
								'aria-hidden': "true",
							dom.div
								id: "notificationContainer",
								dom.div
									id: "notificationTitle",
									"Notifications"
								dom.div
									id: "notificationsBody",
									style: {overflow: "auto", maxHeight: "400px"},	
									for notification in @state.notifications
										React.createElement Notification, key: notification.id, notification: notification			
								dom.div
									id: "notificationFooter",
									dom.a
										href: "#",
										"See All"
						dom.li 
							className: "menu-item-bar",
							dom.a 
								className: "radius-10 item-selected",
								"Cards"	
							dom.ul
								className: "menu vertical item-white",
								dom.li 
									className: "item-selected",
									dom.a
										href: "/questions/new",
										dom.i
											className: "fa fa-plus",
											'aria-hidden': "true",
											" New Card",
								dom.li
									className: "item-selected",
									dom.a
										href: "/questions",
										dom.i
											className: "fa fa-eye",
											'aria-hidden': "true",
											" Show Cards",
								dom.li
									className: "item-selected",
									dom.a
										href: "/cards_run_filter",
										dom.i
											className: "fa fa-play",
											onClick: @runCardClicked,
											'aria-hidden': "true",
											" Run Card",
						dom.li 
							className: "menu-item-bar",
							dom.a 
								className: "radius-10 item-selected",
								"Sessions"	
							dom.ul
								className: "menu vertical item-white",
								dom.li 
									className: "item-selected",
									dom.a
										href: "/sessions/new",
										dom.i
											className: "fa fa-plus",
											'aria-hidden': "true",
											" New Session",								
								dom.li
									className: "item-selected",
									dom.a
										href: "/sessions",
										dom.i
											className: "fa fa-play",
											'aria-hidden': "true",
											" Run Session",
						dom.li 
							className: "menu-item-bar",
							dom.a 
								className: "radius-10 card-mode-btn",
								"#{@state.points} TOKENS"
						dom.li {},
							dom.a
								href: "#",
								dom.i
									className: "fa fa-cog fa-2x",
									'aria-hidden': "true",
							dom.ul
								className: "menu vertical",
								dom.li 
									className: "item-selected",
									dom.a
										rel: "",
										href: @props.profile_settings,
										ref: "",
										dom.i
											className: "fa fa-user-circle-o",
											'aria-hidden': "true",
											"Profile Settings"
								dom.li 
									className: "item-selected",
									dom.a
										'data-method': "delete",
										rel: "nofollow",
										href: @props.sign_out,
										ref: "signOut",
										dom.i
											className: "fa fa-sign-out",
											'aria-hidden': "true",
											"SignOff"
								
@Notification = React.createClass
	displayName: 'Notification'
	render: ->
		if @props.notification.category == "vote"
			icon = "fa fa-thumbs-o-up fa-2x"
			colorNotification = "green"
		if @props.notification.category == "comment"
			icon = "fa fa-comments-o fa-2x"
			colorNotification = "#8a8a8a"
		if @props.notification.category == "flag"
			icon = "fa fa-flag-o fa-2x"
			colorNotification = "red"
		if @props.notification.category == "suspend"
			icon = "fa fa-ban fa-2x"
			colorNotification = "red"
		if @props.notification.category == "reactivate"
			icon = "fa fa-check fa-2x"
			colorNotification = "green"
		if @props.notification.category == "tokens_positive"
			icon = "fa fa-trophy fa-2x"
			colorNotification = "green"
		if @props.notification.category == "tokens_negative"
			icon = "fa fa-minus fa-2x"
			colorNotification = "red"
		dom.div 
			className: "row notifications",			
				dom.div
					className: "small-2 columns"	
					dom.i
						className: icon,
						'aria-hidden': "true",
				dom.a
					href: @props.notification.source
					dom.div
						className: "small-10 columns"		
						dom.h6 
							style: {color: colorNotification},	
							@props.notification.message



