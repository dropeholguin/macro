class AddReferencesSessionToQuestions < ActiveRecord::Migration[5.0]
  def change
  	add_reference :questions, :session, index: true
  end
end
