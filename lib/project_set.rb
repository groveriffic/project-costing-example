require 'project'
require 'reimbursement_date'

class ProjectSet
  def initialize(projects)
    @projects = projects
  end

  def reimbursement_type(date)
    # travel days act like bookends
    # changes in city_cost would seem to indicate travel
    earlier_city_cost = city_cost(date - 1)
    current_city_cost = city_cost(date)
    later_city_cost = city_cost(date + 1)

    return nil unless current_city_cost
    return :travel unless earlier_city_cost == current_city_cost
    return :travel unless current_city_cost == later_city_cost
    return :full
  end

  def city_cost(date)
    active_projects = @projects.select{ |project| project.include?(date) }
    return :high if active_projects.any?{ |p| p.city_cost == :high }
    return :low if active_projects.any?{ |p| p.city_cost == :low }
    return nil
  end

  def start_date
    @projects.map{ |p| p.start_date }.min
  end

  def end_date
    @projects.map{ |p| p.end_date }.max
  end

  def each_date
    (start_date..end_date).each do |date|
      yield date if @projects.any?{ |p| p.include?(date) }
    end
  end

end
