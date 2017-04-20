NewCard = React.createFactory(Components.NewCard)
describe 'NewCard', ->
	beforeEach ->
		ReactTest = React.addons.TestUtils
		@NewCard = ReactTest.renderIntoDocument(NewCard("Create a card component"))
	it 'has a title for new a card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_title').length).toEqual(1)
		expect($(html).find('#question_title').text()).toEqual("Title for A CARD")
	it 'has a description for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#description').length).toEqual(1)
		expect($(html).find('#description' ).text()).toEqual("Description for A CARD")
	it 'has an explanation for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#explanation').length).toEqual(1)
		expect($(html).find('#explanation').text()).toEqual("Explanation for A CARD")
	it 'has an tag_list for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_tag_list').length).toEqual(1)
		expect($(html).find('#question_tag_list').text()).toEqual("SAS Programming")
	