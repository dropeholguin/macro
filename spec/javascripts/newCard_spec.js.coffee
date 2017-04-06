NewCard = React.createFactory(Components.NewCard)
describe 'NewCard', ->
	beforeEach ->
		ReactTest = React.addons.TestUtils
		@NewCard = ReactTest.renderIntoDocument(NewCard( name: "My first test"))
	it 'has a title for new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('h4').text()).toEqual("CREATE A CARD")