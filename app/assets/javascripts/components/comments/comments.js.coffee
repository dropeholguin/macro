dom = React.DOM

@Comments = React.createClass
	displayName: 'Comments'
	getInitialState: ->
		load_comment: []
		comments: @props.comments
	formSubmitted: (event) ->
		event.preventDefault()
		$.ajax
			url: @props.url
			type: "POST"
			data: $(@refs.commentForm).serialize()
			success: (data) =>
				console.log ("this is: " + (data))
				comment = $("#comment_comment_markdown").val()	
				@setState({comment_generated: comment})
				$('#commented').append('<div id="show_comment" class="row comment-box" style=""><h4>You commented:</h4><div class="small-1 columns"><span><i class="fa fa-commenting-o"></i></span></div><div class="small-11 columns"></div>'+@state.comment_generated+'</div>')	 
	componentDidMount: ->
	loadCommentsClicked: (event) ->
		event.preventDefault()
		@setState({load_comment: "div:hidden"})
	render: ->
		dom.div
			className: "root",
			dom.form
				ref: "commentForm",
				onSubmit: @formSubmitted,
				id: "new_comment",
				className: "new_comment",				
				dom.input
					key: "utf8"
					name: "utf8"
					type: "hidden"
					value: "✓"
				dom.input({
					key: "authenticity_token"
					name: "authenticity_token"
					type: "hidden"
					value: @props.csrfToken
					});
				dom.div
					className: "form-group",
					dom.input
						id: "comment_comment_markdown",
						type: "text",
						name: "comment[comment_markdown]",
						placeholder: "Write a comment..."
				dom.div
					className: "actions comments",
					dom.button
						ref: "commentClicked",
						'data-no-turbolink': true,
						className: "button large radius-10",
						type: "submit",
						name: "button",	
						"Comment"
				dom.div
					id: "commented"	
				for comment in @state.comments
					React.createElement ShowComments, key: comment.id, comment: comment, load_comment: @state.load_comment,
				dom.div
					className: "small-12 text-center columns",
					dom.button
						onClick: @loadCommentsClicked,
						className: "button large radius-10",
						"Load more..."

@ShowComments = React.createClass
	displayName: 'ShowComments'
	componentDidMount: ->	
		console.log (@props.load_comment)
		$(@refs.showComment).slice(1, 2).show()		
	componentWillUpdate: ->
		console.log (@props.load_comment)	
		$(@refs.showComment).slice(0, 5).show()
	render: ->
	 	dom.div
	 		id: "show_comment",
	 		ref: "showComment",
	 		className: "row comment-box",
	 		style: {display: "none"}, 
 			dom.h4 {},
 				@props.comment.user_id,
 			dom.div
 				className: "small-1 columns",
 				dom.span {},	
					dom.i
						className: "fa fa-commenting-o",
 			dom.div
 				className: "small-11 columns",
				@props.comment.comment_markdown

	  

