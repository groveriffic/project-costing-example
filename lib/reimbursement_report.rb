require 'reimbursement_date'

class ReimbursementReport

  def initialize(reimbursement_dates)
    date_reported = {}
    reimbursement_dates.each do |rd|
      if date_reported[rd.date]
        raise "date: #{rd.date} appears more than once in ReimbursementReport"
      end
      date_reported[rd.date] = true
    end

    @reimbursement_dates = reimbursement_dates
  end

  def to_s
    s = "Reimbursement Report\n"
    @reimbursement_dates.each do |rd|
      s += " " + rd.to_s + "\n"
    end
    s += "total: $#{total}"
    return s
  end

  def total
    return @reimbursement_dates.map { |rd| rd.rate }.sum
  end

  def ReimbursementReport.from_project_set(project_set)
    reimbursement_dates = []
    project_set.each_date do |date|
      city_cost = project_set.city_cost(date)
      reimbursement_type = project_set.reimbursement_type(date)
      reimbursement_dates << ReimbursementDate.new(date, city_cost, reimbursement_type)
    end

    return ReimbursementReport.new(reimbursement_dates)
  end
end
