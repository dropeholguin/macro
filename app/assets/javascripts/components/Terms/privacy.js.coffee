dom = React.DOM 

@Privacy = React.createClass
  displayName: "Privacy Policy"

  getDefaultProps: ->
    privacy_body: ''
    privacy_id: null
    privacy_version: ''
    privacy_category: ''

  render: ->
    dom.div
      className: "root"
      dom.div
        className: "row"
        dom.div 
          className: "logo-container margin-top-40"
          dom.a
            href: "/"
            className: "logo"
        dom.div
          className: "privacy_and_terms small-12 medium-9 medium-centered large-9 large-centered columns"
          dom.h2
            className: "bold"
            "PRIVACY POLICY"
          dom.p 
            dangerouslySetInnerHTML: __html: @props.privacy_body
