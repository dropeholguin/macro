dom = React.DOM 	

@GithubButton = React.createClass
	displayName: 'GitHub'
	render: ->
		dom.div
			className: "row",
			dom.div
				className: "#{@props.small} #{@props.medium} #{@props.large} small-centered medium-centered large-centered columns text-center",	
				dom.a
					className: "button expanded btn-linkedin github-color radius-40",
					href: @props.url,
					dom.i
						className: "fa fa-github fa-2x",
						'aria-hidden': "true",
					dom.span 
						className: "fntsize-25",
						" Integrate with GitHub ",

@StackOverflowButton = React.createClass
	displayName: 'StackOverflow'
	render: ->
		dom.div
			className: "row",
			dom.div
				className: "#{@props.small} #{@props.medium} #{@props.large} small-centered medium-centered large-centered columns text-center",	
				dom.a
					className: "button expanded btn-linkedin stackoverflow-color radius-40",
					href: @props.url,
					dom.i
						className: "fa fa-stack-overflow fa-2x",
						'aria-hidden': "true",
					dom.span 
						className: "fntsize-25",
						" Integrate with StackOverflow ",