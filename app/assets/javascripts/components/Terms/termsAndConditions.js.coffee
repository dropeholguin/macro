dom = React.DOM 

@Terms = React.createClass
  displayName: 'Terms and Conditions'

  getDefaultProps:->
    terms_body: ''
    terms_id: null
    terms_version: ''
    terms_category: ''

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
            "SASENSEI TERMS OF USE"
          dom.p 
            dangerouslySetInnerHTML: __html: @props.terms_body.toString()
