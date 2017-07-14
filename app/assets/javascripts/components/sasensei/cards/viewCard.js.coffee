dom = React.DOM 

@ViewCardSasensei = React.createClass
	displayName: 'ViewCardSasensei'
	cardOnHover: (event)->
		$(@refs.actions).show()
	cardOnHoverOut: (event)->
		$(@refs.actions).hide()
	deleteCard: (event)->
		$(@refs.cardSasensei).fadeOut()
		$.ajax
			type: "POST"
			url: "/questions/" + @props.id
			dataType: "json"
			data: {"_method":"delete"}
			success: (data)=>
	render: ->
		dom.div
			ref: "cardSasensei"
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
					onClick: @deleteCard
					className: "button button-delete"
					'data-confirm': "Are you sure?",
					'data-method': "delete",
					'data-remote': true
					rel: "nofollow",

