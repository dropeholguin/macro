dom = React.DOM

@Comments = React.createClass
	displayName: 'Comments'
	getInitialState: ->
		load_comment: []
	formSubmitted: (event) ->
		event.preventDefault()
		$.ajax
			url: @props.url
			type: "POST"
			data: $(@refs.commentForm).serialize()
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
						'data-no-turbolink': true,
						className: "button large radius-10",
						type: "submit",
						name: "button",	
						"Comment"	
				for comment in @props.comments
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

	  

