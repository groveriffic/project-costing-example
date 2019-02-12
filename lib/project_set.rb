require 'project'

class ProjectSet
  def initialize(projects)
    @projects = projects
  end

  def reimbursement_type(date)
    projects = @projects.select{ |project| project.include?(date) }

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

  def ProjectSet.reimbursement_rate(city_cost, reimbursement_type)
    return 0 if city_cost.nil?
    return 0 if reimbursement_type.nil?

    raise "city_cost must be :high or :low" unless [:high, :low].include?(city_cost)
    raise "reimbursement_type must be :travel or :full" unless [:travel, :full].include?(reimbursement_type)

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

    raise "unhandled city_cost/reimbursement_type combination"
  end
end
