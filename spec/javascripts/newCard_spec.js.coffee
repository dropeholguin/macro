NewCard = React.createFactory(Components.NewCard)
describe 'NewCard', ->
	beforeEach ->
		ReactTest = React.addons.TestUtils
		@NewCard = ReactTest.renderIntoDocument(NewCard("Create a card component"))
	it 'multiple choice selected for new a card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#choice').length).toEqual(1)
		expect($(html).find('#choice').text()).toEqual("Multiple choice")
	it 'has a title for new a card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_title').length).toEqual(1)
		expect($(html).find('#question_title').text()).toEqual("Title for A CARD")
	it 'has a description for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#description').length).toEqual(1)
		expect($(html).find('#description' ).text()).toEqual("Description for A CARD")
	it 'has an answer for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_answers_attributes_0_answer_markdown').length).toEqual(1)
		expect($(html).find('#question_answers_attributes_0_answer_markdown' ).text()).toEqual("Answer 1")
	it 'has an answer for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_answers_attributes_0_is_correct').length).toEqual(1)
		expect($(html).find('#question_answers_attributes_0_is_correct' ).text()).toEqual("Correct")
	it 'has an answer for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_answers_attributes_1_answer_markdown').length).toEqual(1)
		expect($(html).find('#question_answers_attributes_1_answer_markdown' ).text()).toEqual("Answer 2")
	it 'has an answer for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_answers_attributes_1_is_correct').length).toEqual(1)
		expect($(html).find('#question_answers_attributes_1_is_correct' ).text()).toEqual("Correct")
	it 'has an answer for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_answers_attributes_2_answer_markdown').length).toEqual(1)
		expect($(html).find('#question_answers_attributes_2_answer_markdown' ).text()).toEqual("Answer 3")
	it 'has an answer for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_answers_attributes_2_is_correct').length).toEqual(1)
		expect($(html).find('#question_answers_attributes_2_is_correct' ).text()).toEqual("Correct")
	it 'has an explanation for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#explanation').length).toEqual(1)
		expect($(html).find('#explanation').text()).toEqual("Explanation for A CARD")
	it 'has an tag_list for a new card',->
		html = ReactDOM.findDOMNode(@NewCard)
		expect($(html).find('#question_tag_list').length).toEqual(1)
		expect($(html).find('#question_tag_list').text()).toEqual("SAS Programming")
	