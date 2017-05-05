dom = React.DOM 

@Test = React.createClass
	getInitialState: ->		
		quest: 0
	testClicked: (event)-> 
    	$.ajax
	      url: @props.test_1
	      type: 'POST' 	
		  success: (data) ->
		    console.log ("r.quest")
	render: ->
		dom.div
			className: "root",
			dom.div
				className: "small-12 columns text-right",
				dom.a 
					className: "button large radius-10",
					onClick: @testClicked,
					ref: "runCard",
					"Test"	 

