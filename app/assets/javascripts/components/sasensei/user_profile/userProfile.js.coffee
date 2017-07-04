dom = React.DOM

@UserProfileSasensei = React.createClass
	displayName: 'UserProfileSasensei'
	render:->
		dom.div
			className: "root",
			dom.div
				className: "row"
				dom.div
					className: "large-11 large-centered columns"
					dom.div 
						className: "text-left row"								
						dom.a
							style:{marginRight: "15px"}
							className: "button large btn-run menu-title uppercase",
							"profile"
						dom.a
							style:{marginRight: "15px"}
							className: "button large btn-run menu-title uppercase",
							"activity"
						dom.a
							className: "button large btn-run menu-title uppercase",
							"settings"
					dom.div
						className: "profile-field row"
						style: {padding: "20px"}
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
								style: {fontSize: "14px"}
								className: "uppercase text-left menu-subtitle"
								"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse id lacus et libero fringilla ultrices ac id justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In vestibulum nulla nisl, eget efficitur turpis fringilla vel. Donec ante massa, iaculis sed leo a, eleifend molestie mauris. Nunc rhoncus mauris lectus, non sodales orci aliquet ut. Nullam nec placerat eros. Cras lacus libero, blandit eget auctor nec, suscipit in ex. Nullam condimentum id quam vel pharetra."



