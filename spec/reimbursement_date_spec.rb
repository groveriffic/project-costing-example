require 'reimbursement_date'
require 'date'

RSpec.describe ReimbursementDate do
  context "#rate" do
    it "A travel day is reimbursed at a rate of 45 dollars per day in a low cost city." do
      date = Date.new(2019, 2, 13)
      city_cost = :low
      reimbursement_type = :travel
      rate = ReimbursementDate.new(date, city_cost, reimbursement_type).rate
      expect(rate).to eq 45
    end

    it "A travel day is reimbursed at a rate of 55 dollars per day in a high cost city." do
      date = Date.new(2019, 2, 13)
      city_cost = :high
      reimbursement_type = :travel
      rate = ReimbursementDate.new(date, city_cost, reimbursement_type).rate
      expect(rate).to eq 55
    end

    it "A full day is reimbursed at a rate of 75 dollars per day in a low cost city." do
      date = Date.new(2019, 2, 13)
      city_cost = :low
      reimbursement_type = :full
      rate = ReimbursementDate.new(date, city_cost, reimbursement_type).rate
      expect(rate).to eq 75
    end

    it "A full day is reimbursed at a rate of 85 dollars per day in a high cost city." do
      date = Date.new(2019, 2, 13)
      city_cost = :high
      reimbursement_type = :full
      rate = ReimbursementDate.new(date, city_cost, reimbursement_type).rate
      expect(rate).to eq 85
    end
  end

end
