class ModelMailer < ApplicationMailer
	default from: 'allan@bowe.io'

	def suspend_question(question)
		@question = question
		mail(to: @question.user.email, subject: "Your question was suspended")
	end

	def approve_question(question)
		@question = question
		mail(to: @question.user.email, subject: "Your question was approved")
	end
end
