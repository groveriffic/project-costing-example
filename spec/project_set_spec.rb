require 'project_set'

RSpec.describe ProjectSet do
  context "#reimbursement_type" do
    it "First day and last day of a project, or sequence of projects, is a travel day."
    it "Any day in the middle of a project, or sequence of projects, is considered a full day."
    it "If there is a gap between projects, then the days on either side of that gap are travel days."
    it "If two projects push up against each other, or overlap, then those days are full days as well."
  end

  context "#reimbursement_rate" do
    it "A travel day is reimbursed at a rate of 45 dollars per day in a low cost city."
    it "A travel day is reimbursed at a rate of 55 dollars per day in a high cost city."
    it "A full day is reimbursed at a rate of 75 dollars per day in a low cost city."
    it "A full day is reimbursed at a rate of 85 dollars per day in a high cost city."
  end

  context "#reimbursement_total" do
    it "Any given day is only ever counted once, even if two projects are on the same day."
  end
end
