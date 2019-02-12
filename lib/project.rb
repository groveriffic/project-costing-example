require 'date'

class Project
  attr_reader :start_date
  attr_reader :end_date
  attr_reader :city_cost

  def initialize(start_date, end_date, city_cost)
    raise "start_date must be a date" unless start_date.is_a? Date
    @start_date = start_date

    raise "end_date must be a date" unless end_date.is_a? Date
    @end_date = end_date

    raise "start_date must be before or on end_date" unless start_date <= end_date

    raise "city_cost must be either :high or :low" unless [:high, :low].include? city_cost
    @city_cost = city_cost
  end

  def include?(date)
    return (@start_date..@end_date).include?(date)
  end

end
