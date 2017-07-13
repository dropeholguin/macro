dom = React.DOM 

@ViewCardSasensei = React.createClass
	displayName: 'ViewCardSasensei'
	cardOnHover: (event)->
		$(@refs.actions).show()
	cardOnHoverOut: (event)->
		$(@refs.actions).hide()
	render: ->
		dom.div
			className: "card-background"
			onMouseEnter: @cardOnHover
			onMouseLeave: @cardOnHoverOut
			dom.div
				className: "large-10 columns"
				dom.a 
					href: "/questions/#{@props.id}"
					dangerouslySetInnerHTML: __html: @props.description.toString()
			dom.div
				ref: 'actions'
				style: {display: "none"}
				className: "large-2 columns"
				dom.a
					className: 'button button-edit'
				dom.a
					className: "button button-delete"
