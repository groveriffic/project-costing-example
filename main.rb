$LOAD_PATH << "./lib"

require 'project'
require 'project_set'
require 'reimbursement_report'

# TODO: To allow this to be used by someone who doesn't know ruby syntax
# We would need to consider parsing an input format like CSV or building a UI
# to enter project data.

# Set 1:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15
puts "Project Set 1"
puts ReimbursementReport.from_project_set(
  ProjectSet.new([
    Project.new(
      Date.new(2015, 9, 1),
      Date.new(2015, 9, 3),
      :low
    )
  ])
)

# Set 2:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
#   Project 2: High Cost City Start Date: 9/2/15 End Date: 9/6/15
#   Project 3: Low Cost City Start Date: 9/6/15 End Date: 9/8/15
puts "\n"
puts "Project Set 2"
puts ReimbursementReport.from_project_set(
  ProjectSet.new([
    Project.new(
      Date.new(2015, 9, 1),
      Date.new(2015, 9, 1),
      :low
    ),
    Project.new(
      Date.new(2015, 9, 2),
      Date.new(2015, 9, 6),
      :high
    ),
    Project.new(
      Date.new(2015, 9, 6),
      Date.new(2015, 9, 8),
      :low
    ),
  ])
)

# Set 3:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15
#   Project 2: High Cost City Start Date: 9/5/15 End Date: 9/7/15
#   Project 3: High Cost City Start Date: 9/8/15 End Date: 9/8/15
puts "\n"
puts "Project Set 3"
puts ReimbursementReport.from_project_set(
  ProjectSet.new([
    Project.new(
      Date.new(2015, 9, 1),
      Date.new(2015, 9, 3),
      :low
    ),
    Project.new(
      Date.new(2015, 9, 5),
      Date.new(2015, 9, 7),
      :high
    ),
    Project.new(
      Date.new(2015, 9, 8),
      Date.new(2015, 9, 8),
      :high
    ),
  ])
)

# Set 4:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
#   Project 2: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
#   Project 3: High Cost City Start Date: 9/2/15 End Date: 9/2/15
#   Project 4: High Cost City Start Date: 9/2/15 End Date: 9/3/15
puts "\n"
puts "Project Set 4"
puts ReimbursementReport.from_project_set(
  ProjectSet.new([
    Project.new(
      Date.new(2015, 9, 1),
      Date.new(2015, 9, 1),
      :low
    ),
    Project.new(
      Date.new(2015, 9, 1),
      Date.new(2015, 9, 1),
      :low
    ),
    Project.new(
      Date.new(2015, 9, 2),
      Date.new(2015, 9, 2),
      :high
    ),
    Project.new(
      Date.new(2015, 9, 2),
      Date.new(2015, 9, 3),
      :high
    ),
  ])
)
