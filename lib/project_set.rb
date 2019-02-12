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
end
