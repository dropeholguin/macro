class AddReferencesToComments < ActiveRecord::Migration[5.0]
  def change
  	add_reference :comments, :user, index: true
  	add_reference :comments, :question, index: true
  end
end
