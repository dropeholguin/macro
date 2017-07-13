dom = React.DOM 

@HeaderResponsive = React.createClass
	render: ->
		dom.div 
			className: "row"
			dom.div
				style: {minHeight: "118px", margin: "auto", background: "#fff"}
				className: "medium-6 small-8 small-centered medium-centered columns"
				dom.div
					className: "row"
					dom.div
						className: "medium-5 small-5 columns kanjis-text text-right"
						@props.kanjis
					dom.div
						className: "medium-7 small-7 columns uppercase menu-title weight text-left" 
						@props.title
				dom.div
					className: "row"
					dom.p
						style: {padding: "0 8px"}
						className: "uppercase text-right menu-subtitle"
						@props.description