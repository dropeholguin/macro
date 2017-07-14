require 'rails_helper'
require "rake"

describe "Ensure we have an overnight process that resets the CARD count to 8" do
 	let(:user){ create(:user) }

	before do
      load File.expand_path("../../../lib/tasks/renew_balance.rake", __FILE__)
      Rake::Task.define_task(:environment)
    end

	it "renew the tokens" do
		expect(user.points).to eq(5)
		expect(User.count).to eq(1)
		Rake::Task["renew_balance:balance"].invoke
		expect(user.points).to eq(8)
	end
end