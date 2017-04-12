dom = React.DOM

@HeaderLoggedIn = React.createClass
	displayName: 'HeaderLoggedIn'
	getDefaultProps: ->
		points: 0
	componentDidMount: ->
		$(document).foundation()
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
								"MACRO PEOPLE",													
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
						dom.li 
							className: "menu-item-bar",
							dom.a 
								className: "radius-10",
								"#{@props.points} Cards Available"
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
										dom.i
											className: "fa fa-sign-out",
											'aria-hidden': "true",
											"Log Out"


