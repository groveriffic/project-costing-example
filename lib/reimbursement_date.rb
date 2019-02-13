class ReimbursementDate
  attr_reader :date, :city_cost, :reimbursement_type

  def initialize(date, city_cost, reimbursement_type)
    raise "city_cost must be :high or :low" unless [:high, :low].include?(city_cost)
    raise "reimbursement_type must be :travel or :full" unless [:travel, :full].include?(reimbursement_type)

    @date = date
    @city_cost = city_cost
    @reimbursement_type = reimbursement_type
  end

  def rate
    if city_cost == :low && reimbursement_type == :travel then
      return 45
    end

    if city_cost == :high && reimbursement_type == :travel then
      return 55
    end

    if city_cost == :low && reimbursement_type == :full then
      return 75
    end

    if city_cost == :high && reimbursement_type == :full then
      return 85
    end

    raise "rate not defined for city_cost: #{city_cost} and reimbursement_type: #{reimbursement_type}"
  end
end
