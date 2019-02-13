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
    projects = projects_on(date)

    if projects.count > 1 then
      return :full
    end

    if projects.empty? then
      return nil
    end

    project = projects.first
    other_projects = @projects - projects

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

  # TODO: Extract as ReimbursementReport class
  def reimbursement_total
    return (start_date..end_date).map { |date|
      cc = city_cost(date)
      rt = reimbursement_type(date)
      if cc.nil? then
        return 0
      else
        return ReimbursementDate.new(date, cc, rt).rate
      end
    }.sum
  end

end
