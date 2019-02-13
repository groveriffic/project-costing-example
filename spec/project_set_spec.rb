require 'project_set'

RSpec.describe ProjectSet do
  context "#reimbursement_type" do
    context "single project" do
      before(:example) do
        @start_date = Date.new(2019, 2, 12)
        @end_date = Date.new(2019, 2, 15)
        @project = Project.new(@start_date, @end_date, :high)
        @project_set = ProjectSet.new([@project])
      end

      it "First day of project is a travel day" do
        expect(@project_set.reimbursement_type(@start_date)).to eq :travel
      end

      it "Last day of project is a travel day" do
        expect(@project_set.reimbursement_type(@end_date)).to eq :travel
      end

      it "days in middle of project are full days" do
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 13))).to eq :full
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 14))).to eq :full
      end
    end

    context "two non-overlapping non-adjacent projects" do
      before(:example) do
        @project_a = Project.new(
          Date.new(2019, 2, 13),
          Date.new(2019, 2, 15),
          :high)
        @project_b = Project.new(
          Date.new(2019, 2, 18),
          Date.new(2019, 2, 20),
          :high)
        @project_set = ProjectSet.new([@project_a, @project_b])
      end
      it "First day and last day of a project, or sequence of projects, is a travel day." do
        expect(@project_set.reimbursement_type(@project_a.start_date)).to eq :travel
        expect(@project_set.reimbursement_type(@project_a.end_date)).to eq :travel
        expect(@project_set.reimbursement_type(@project_b.start_date)).to eq :travel
        expect(@project_set.reimbursement_type(@project_b.end_date)).to eq :travel
      end

      it "days in middle of project are full days" do
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 14))).to eq :full
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 19))).to eq :full
      end
    end

    context "two non-overlapping adjacent projects" do
      before(:example) do
        @project_a = Project.new(
          Date.new(2019, 2, 13),
          Date.new(2019, 2, 15),
          :high)
        @project_b = Project.new(
          Date.new(2019, 2, 16),
          Date.new(2019, 2, 18),
          :high)
        @project_set = ProjectSet.new([@project_a, @project_b])
      end

      it "First day and last day of a project, or sequence of projects, is a travel day." do
        expect(@project_set.reimbursement_type(@project_a.start_date)).to eq :travel
        expect(@project_set.reimbursement_type(@project_b.end_date)).to eq :travel
      end

      it "days in middle of project are full days" do
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 14))).to eq :full
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 17))).to eq :full
      end

      it "the end of the first project is considered a full day because it is adjacent to the second project" do
        expect(@project_set.reimbursement_type(@project_a.end_date)).to eq :full
      end

      it "the start of the second project is considered a full day because it is adjacent to the first project" do
        expect(@project_set.reimbursement_type(@project_b.start_date)).to eq :full
      end
    end

    context "two overlapping projects" do
      before(:example) do
        @project_a = Project.new(
          Date.new(2019, 2, 13),
          Date.new(2019, 2, 15),
          :high)
        @project_b = Project.new(
          Date.new(2019, 2, 14),
          Date.new(2019, 2, 18),
          :high)
        @project_set = ProjectSet.new([@project_a, @project_b])
      end

      it "First day and last day of a sequence of projects, is a travel day." do
        expect(@project_set.reimbursement_type(@project_a.start_date)).to eq :travel
        expect(@project_set.reimbursement_type(@project_b.end_date)).to eq :travel
      end

      it "days in middle of project are full days" do
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 16))).to eq :full
        expect(@project_set.reimbursement_type(Date.new(2019, 2, 17))).to eq :full
      end

      it "the end of the first project is considered a full day because it is within to the second project" do
        expect(@project_set.reimbursement_type(@project_a.end_date)).to eq :full
      end

      it "the start of the second project is considered a full day because it is within to the first project" do
        expect(@project_set.reimbursement_type(@project_b.start_date)).to eq :full
      end
    end

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

  context "#city_cost" do
    before(:example) do
      @project_a = Project.new(Date.new(2019, 2, 12), Date.new(2019, 2, 15), :low)
      @project_b = Project.new(Date.new(2019, 2, 14), Date.new(2019, 2, 20), :high)
      @project_set = ProjectSet.new([@project_a, @project_b])
    end

    it "returns low during a low city_cost project" do
      expect(@project_set.city_cost(@project_a.start_date)).to eq :low
    end

    it "returns high during a high city_cost project" do
      expect(@project_set.city_cost(@project_b.end_date)).to eq :high
    end

    it "returns high when high and low city_cost projects overlap" do
      # Note: This is assuming we would prioritize high city_cost, but it wasn't specified in the original requirements
      # Will update if this assumption is incorrect
      expect(@project_set.city_cost(@project_a.end_date)).to eq :high
    end

  end
end
