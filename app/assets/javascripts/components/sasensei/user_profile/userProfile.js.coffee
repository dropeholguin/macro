dom = React.DOM

@UserProfileSasensei = React.createClass
	displayName: 'UserProfileSasensei'
	componentDidMount: ->
		$(document).foundation();
	deleteClicked: ->
		$.ajax
			url: "/api/v1/users/" + @props.user.id
			type: 'DELETE'
			success: (res) =>
				alert res.message
				window.location.replace("/")
			error: (e) =>
				console.log e
				alert 'An error occurred, try again later'
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-10 large-centered columns"
					dom.div
						className: "text-left row"
						'data-deep-link': "true"
						'data-update-history': "true"
						'data-deep-link-smudge': "true"
						'data-deep-link-smudge': "500"
						'data-tabs': ''
						id: "settings-tabs"
						dom.span
							className: "tabs-title is-active"
							dom.a
								href: "#tab_profile"
								style:{ marginRight: "15px" }
								className: "button large button-medium menu-title uppercase",
								'aria-selected': "true"
								'Profile'
						dom.span
							className: "tabs-title"
							dom.a
								href: '#tab_activity'
								style:{ marginRight: "15px" }
								className: "button large button-medium menu-title uppercase",
								'Activity'
						dom.span
							className: "tabs-title"
							dom.a
								'data-tabs-target': "#panel2"
								href: "#tab_settings"
								style:{ marginRight: "15px" }
								className: "button large button-medium menu-title uppercase",
								'Settings'
					dom.div
						'data-tabs-content': "settings-tabs"
						dom.div
							className: "tabs-panel profile-field row"
							id: 'tab_profile'
							style: { padding: "20px" }
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"user: #{@props.user.id}"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"London, united kingdom"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Rank: Master Sensei"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Member for: #years #months"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Tokens: "
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Last seen: ...Ago"
							dom.div
								className: "large-12 columns"
								dom.p
									className: "menu-title uppercase"
									"Biography"
								dom.p 
									style: { fontSize: "14px" }
									className: "uppercase text-left menu-subtitle"
									"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse id lacus et libero fringilla ultrices ac id justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In vestibulum nulla nisl, eget efficitur turpis fringilla vel. Donec ante massa, iaculis sed leo a, eleifend molestie mauris. Nunc rhoncus mauris lectus, non sodales orci aliquet ut. Nullam nec placerat eros. Cras lacus libero, blandit eget auctor nec, suscipit in ex. Nullam condimentum id quam vel pharetra."
							dom.div
								className: "large-12 columns"
								dom.p
									className: "menu-title uppercase"
									"Top tag"
								dom.div
									className: "large-4 columns"
									dom.a 
										className: "button large normal-title"
										href: "#"
										"SAS MACRO"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
								dom.div
									className: "large-4 columns"
									dom.a 
										className: "button large normal-title"
										href: "#"
										"SAS MACRO"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
								dom.div
									className: "large-4 columns"
									dom.a 
										className: "button large normal-title"
										href: "#"
										"SAS MACRO"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
									dom.p 
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"Longest Streak"
						dom.div
							className: 'tabs-panel profile-field row'
							id: 'tab_activity'
							dom.h1 
								'Activity'
						dom.div
							className: 'tabs-panel profile-field row'
							id: 'tab_settings'
							style: { padding: "20px" }
							dom.div
								className: "large-6 columns"
								dom.input
									className: "menu-title uppercase"
									value: "#{@props.user.username}"
							dom.div
								className: "large-6 columns"
								dom.input
									className: "menu-title uppercase medium-8"
									value: "London, united kingdom"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Rank: Master Sensei"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Member for: #years #months"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Tokens: "
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Last seen: ...Ago"
							dom.div
								className: "large-6 columns"
								dom.p
									className: "menu-title uppercase"
									"Biography"
							dom.div
								className: "large-6 columns"
								dom.span
									className: "menu-title uppercase"
									'Public Profile'
									dom.input
										name: "is_public"
										ref: "is_public"
										type: "checkbox"
							dom.div
								className: "large-12 columns"
								dom.textarea
									style: { fontSize: "14px" }
									rows: 5
									className: "uppercase text-left menu-subtitle"
									value: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse id lacus et libero fringilla ultrices ac id justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In vestibulum nulla nisl, eget efficitur turpis fringilla vel. Donec ante massa, iaculis sed leo a, eleifend molestie mauris. Nunc rhoncus mauris lectus, non sodales orci aliquet ut. Nullam nec placerat eros. Cras lacus libero, blandit eget auctor nec, suscipit in ex. Nullam condimentum id quam vel pharetra."
							dom.div
								className: "large-12 columns"
								dom.div
									className: "large-6 columns"
									dom.p
										className: "menu-title uppercase"
										"Accounts"
									dom.div
										className: "large-8"
										React.createElement LinkedInButton
										React.createElement GoogleButton
										React.createElement FacebookButton
								dom.div
									className: "large-6 columns"
									dom.p
										className: "menu-title uppercase"
										"Delete Account"
									dom.p
										style: { fontSize: "14px" }
										className: "uppercase text-left menu-subtitle"
										"All your content will be saved but your account will be removed"
									dom.a
										style: { fontSize: "14px", color: '#f51515' }
										className: "uppercase text-left menu-subtitle"
										'data-open': "exampleModal1"
										"Delete Account"
			dom.div
				className: "tiny reveal",
				style: { padding: '20px 40px' }
				id: "exampleModal1",
				'data-reveal': ''
				dom.h1
					className: 'uppercase menu-title text-center',
					"Delete Account"
				dom.p
					className: 'uppercase menu-subtitle text-center',
					style: { fontSize: "14px", padding: "0px 20px 15px" },
					"Are you sure you want to delete your account?"
				dom.a
					style: { fontSize: "14px", color: '#f51515' },
					className: "uppercase text-left menu-subtitle",
					onClick: @deleteClicked,
					"Delete Account"
				dom.a
					style: { fontSize: "14px" },
					className: "uppercase pull-right menu-subtitle",
					'data-close': '' ,
					'aria-label': "Close modal",
					"Cancel"
