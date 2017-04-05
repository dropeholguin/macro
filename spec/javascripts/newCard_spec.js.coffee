describe 'NewCard', ->
	beforeEach ->
		ReactTest = React.addons.TestUtils
		@NewCard = ReactTest.renderIntoDocument(NewCard(initialName: 'my first test'))
	it 'has a title for new card',->
		
