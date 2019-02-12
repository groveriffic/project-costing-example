require 'project'

class ProjectSet
  def initialize(projects)
    @projects = projects
  end

  def reimbursement_type(date)
    if @projects.any?{ |project| project.start_date == date || project.end_date == date }
      return :travel
    end

    if @projects.any?{ |project| project.include?(date) }
      return :full
    end

    return nil
  end
end
