require 'project'
require 'date'

RSpec.describe Project do

  context ".new with valid input" do
    it "just works" do
      start_date = Date.new(2019, 2, 12)
      end_date = Date.new(2019, 3, 1)
      city_cost = :high
      project = Project.new(start_date, end_date, city_cost)
      expect(project.start_date).to eq(start_date)
      expect(project.end_date).to eq(end_date)
      expect(project.city_cost).to eq(city_cost)
    end
  end

  before(:example) do
    @start_date = Date.new(2019, 2, 12)
    @end_date = Date.new(2019, 2, 15)
    city_cost = :high
    @project = Project.new(@start_date, @end_date, city_cost)
  end

  context "#include?" do
    example { expect(@project.include?(@start_date - 1)).to be false }
    example { expect(@project.include?(@start_date)).to be true }
    example { expect(@project.include?(@start_date + 1)).to be true }
    example { expect(@project.include?(@start_date + 2)).to be true }
    example { expect(@project.include?(@end_date)).to be true }
    example { expect(@project.include?(@end_date + 1)).to be false }
  end

end
