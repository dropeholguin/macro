dom = React.DOM 

@Privacy = React.createClass
  displayName: "Privacy Policy"
  componentDidMount: ->
    console.log this.props
  getDefaultProps: ->
    privacy_body: ''
    privacy_id: null
    privacy_version: ''
    privacy_category: ''
  handleClick: ->
    if this.props.privacy_id
      $.ajax
        url: '/privacy/' + this.props.privacy_id + '/accept',
        type: 'PATCH', 
        dataType: 'json'
        contentType: "application/json"
        success: (data) =>
          if data.success
            # redirect to home page
            window.location.replace("/")
          else
            alert 'some error occurred, try again later'
            console.log data
        error: (e) =>
          alert 'some error occurred, try again later'
          console.log e.responseJSON
    else
      alert 'some error occurred, try again later'

  render: ->
    dom.div
      className: "root"
      dom.div
        className: "row"
        dom.div
          className: "small-12 medium-9 medium-centered large-9 large-centered columns"
          dom.h2
            className: "bold"
            "PRIVACY POLICY"
          dom.p 
            dangerouslySetInnerHTML: __html: @props.privacy_body.toString()
          # dom.button
          #   className: 'button expanded primary radius-40 white'
          #   onClick: @handleClick
          #   'I Accept'
