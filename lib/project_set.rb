require 'project'
require 'reimbursement_date'

class ProjectSet
  def initialize(projects)
    @projects = projects
  end

  def include?(date)
    return @projects.any?{ |p| p.include?(date) }
  end

  def reimbursement_type(date)
    return nil unless include?(date)
    # travel days act like bookends
    return :travel unless include?(date - 1)
    return :travel unless include?(date + 1)
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
