require 'project'
require 'reimbursement_date'

class ProjectSet
  def initialize(projects)
    @projects = projects
  end

  def projects_on(date)
    return @projects.select{ |project| project.include?(date) }
  end

  def reimbursement_type(date)
    return :travel if date == start_date
    return :travel if date == end_date

    projects = projects_on(date)

    return nil if projects.empty?
    return :full if projects.count > 1

    project = projects.first
    other_projects = @projects - projects

    # TODO: Rewrite for clarity
    if date == project.start_date || date == project.end_date then
      if other_projects.any?{ |other_project| other_project.adjacent?(date) } then
        return :full
      end

      return :travel
    end

    return :full
  end

  def city_cost(date)
    projects = projects_on(date)

    if projects.any?{ |project| project.city_cost == :high }
      return :high
    end

    if projects.any?{ |project| project.city_cost == :low }
      return :low
    end

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
      if @projects.any?{ |project| project.include?(date) }
        yield date
      end
    end
  end

end
