dom = React.DOM

@Comments = React.createClass
	displayName: 'Comments'
	formSubmitted: (event) ->
		event.preventDefault()
		$.ajax
			url: @props.url
			type: "POST"
			data: $(@refs.commentForm).serialize()
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
				dom.div
					className: "actions",
					dom.button
						'data-no-turbolink': true,
						className: "button large radius-10",
						type: "submit",
						name: "button",	
						"Comment"	
				for comment in @props.comments
					React.createElement ShowComments, key: comment.id, comment: comment,

@ShowComments = React.createClass
	displayName: 'ShowComments'
	render: ->
	 	dom.div
	 		className: "row comment-box", 
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

	  

