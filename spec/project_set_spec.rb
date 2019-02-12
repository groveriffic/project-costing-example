require 'project_set'

RSpec.describe ProjectSet do
  context "#reimbursement_type" do
    it "First day and last day of a project, or sequence of projects, is a travel day." do
      start_date = Date.new(2019, 2, 12)
      end_date = Date.new(2019, 2, 15)
      project = Project.new(start_date, end_date, :high)
      project_set = ProjectSet.new([project])
      expect(project_set.reimbursement_type(start_date)).to eq :travel
      expect(project_set.reimbursement_type(end_date)).to eq :travel
    end

    it "Any day in the middle of a project, or sequence of projects, is considered a full day." do
      start_date = Date.new(2019, 2, 12)
      end_date = Date.new(2019, 2, 15)
      project = Project.new(start_date, end_date, :high)
      project_set = ProjectSet.new([project])
      expect(project_set.reimbursement_type(Date.new(2019, 2, 13))).to eq :full
      expect(project_set.reimbursement_type(Date.new(2019, 2, 14))).to eq :full
    end

    it "If there is a gap between projects, then the days on either side of that gap are travel days." do
      project_a = Project.new(Date.new(2019, 2, 12), Date.new(2019, 2, 15), :high)
      project_b = Project.new(Date.new(2019, 2, 17), Date.new(2019, 2, 20), :high)
      project_set = ProjectSet.new([project_a, project_b])

      expect(project_set.reimbursement_type(project_a.end_date)).to eq :travel
      expect(project_set.reimbursement_type(project_b.start_date)).to eq :travel
    end

    context "If two projects push up against each other, or overlap, then those days are full days as well." do
      it "overlap" do
        project_a = Project.new(Date.new(2019, 2, 12), Date.new(2019, 2, 15), :high)
        project_b = Project.new(Date.new(2019, 2, 14), Date.new(2019, 2, 20), :high)
        project_set = ProjectSet.new([project_a, project_b])

        expect(project_set.reimbursement_type(project_a.end_date)).to eq :full
        expect(project_set.reimbursement_type(project_b.start_date)).to eq :full
      end

      it "adjacent" do
        project_a = Project.new(Date.new(2019, 2, 12), Date.new(2019, 2, 15), :high)
        project_b = Project.new(Date.new(2019, 2, 16), Date.new(2019, 2, 20), :high)
        project_set = ProjectSet.new([project_a, project_b])

        expect(project_set.reimbursement_type(project_a.end_date)).to eq :full
        expect(project_set.reimbursement_type(project_b.start_date)).to eq :full
      end
    end
  end

  context ".reimbursement_rate" do
    it "A travel day is reimbursed at a rate of 45 dollars per day in a low cost city." do
      expect(ProjectSet.reimbursement_rate(:low, :travel)).to eq 45
    end

    it "A travel day is reimbursed at a rate of 55 dollars per day in a high cost city." do
      expect(ProjectSet.reimbursement_rate(:high, :travel)).to eq 55
    end

    it "A full day is reimbursed at a rate of 75 dollars per day in a low cost city." do
      expect(ProjectSet.reimbursement_rate(:low, :full)).to eq 75
    end

    it "A full day is reimbursed at a rate of 85 dollars per day in a high cost city." do
      expect(ProjectSet.reimbursement_rate(:high, :full)).to eq 85
    end
  end

  context "#reimbursement_total" do
    it "Any given day is only ever counted once, even if two projects are on the same day."
  end
end
