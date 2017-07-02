import React from 'react'
import { connect } from 'react-redux';

import { getCards, logoutAndRedirect } from '../../../actions'

dom = React.DOM 

HeaderDesktop = React.createClass
	displayName: ''
	getInitialState: ->
		points: @props.points
		current_points: []
		notifications: []
		kanjis: "質問"
		title: "Cards"
		description: "take a knife and study the ancient art of sas. it costs 2 tokens to enter the dojo."
	getDefaultProps: ->
		points: 0
	componentDidMount: ->
		this.props.dispatch(getCards())
		# $(document).foundation()
		if(@props.points == null)
			@setState(
				points: 0 
			)
		path = window.location.pathname
		if path == "/"
			$(@refs.logo).hide()
			$(@refs.titlePath).hide()
		else 
			$(@refs.logo).show()
			$(@refs.titlePath).show()
		#Routes validation to change title, kanjis, and description depending from the acctive path
		if path == "/sessions"
			@setState({kanjis: "試験", title: "sessions", description: "Prove your sas power! It costs 16 tokens to enter the dojo."})
		if path == "/questions/new"
			@setState({kanjis: "支給", title: "submit", description: "Gain more cards by creating cards!"})
	componentWillMount: ->
		# @fetchPoints()
		# setInterval(@fetchPoints, 1000)
	fetchPoints: ->
		$.ajax
			url: @props.tokens_wallet_path
			type: 'post'
			dataType: 'json'
			data: points: @state.points
			success: (data) =>
				@setState({points: data.tokens, total_notifications: data.number_notifications, notifications: data.notifications})
				if @state.total_notifications == 0
					@setState({hide_number: "none"})
				else
					@setState({hide_number: "block"})
				console.log data

	doLogout: (event) ->
		event.preventDefault()
		this.props.dispatch(logoutAndRedirect())

	render: ->
		dom.div 
			className: "row bottom-60"
			dom.div
				className: "large-3 medium-3 columns"
				dom.a
					ref: "logo" 
					className: "logo margin-top-40",
					href: "/"
			dom.div
				className: "large-6 medium-6 columns text-center"
				dom.div 
					className: "row"
					ref: "titlePath"
					dom.div
						style: {minHeight: "190px", margin: "auto", background: "#fff", maxWidth: "80%"}
						className: "large-10 large-centered columns"
						dom.div
							className: "row"
							dom.div
								className: "large-5 columns kanjis-text font-48"
								@state.kanjis
							dom.div
								className: "large-7 columns uppercase menu-title weight text-left font-48" 
								@state.title
						dom.div
							className: "row"
							dom.p
								style: {padding: "18px", fontSize: "16px"}
								className: "uppercase text-left menu-subtitle"
								@state.description

			dom.div
				className: "large-3 medium-3 columns button-info-status uppercase text-status"
				dom.div {}, 
					"User: #{@props.current_user.id}"
				dom.div {}, 
					"Rank: 1"
				dom.div {}, 
					"Tokens: #{@state.points}"
				dom.div 
					style: {borderTop: "1px solid #8a8a8a", margin: "10px 0"}
					className: "menu-title uppercase text-center"
					dom.a
						onClick: @doLogout,
						rel: "nofollow",
						className: "menu-title",
						"Logout"

mapStateToProps = (state) =>
	return state.auth

export default connect(mapStateToProps)(HeaderDesktop)
