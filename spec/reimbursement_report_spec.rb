require 'reimbursement_report'
require 'reimbursement_date'
require 'date'

RSpec.describe ReimbursementReport do
  context '.new' do
    it "Any given day is only ever counted once, even if two projects are on the same day." do
      reimbursement_date = ReimbursementDate.new(Date.new(2019, 2, 13), :low, :travel)
      expect{ ReimbursementReport.new([reimbursement_date, reimbursement_date]) }
      .to raise_error "date: 2019-02-13 appears more than once in ReimbursementReport"
    end
  end

  context '#total' do
    it "need to verify against expected results"
  end
end
