dom = React.DOM  

@CardTutorial = React.createClass

	render: ->
		dom.div
			className: "root",
			dom.h1 {},
			"HELLO!"

