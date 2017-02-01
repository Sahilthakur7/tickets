require "rails_helper"

RSpec.describe TicketPolicy do
    context "permissions" do
        subject { TicketPolicy.new(user, ticket) }

        let(:user) { FactoryGirl.create(:user) }
        let(:project) { FactoryGirl.create(:project) }
        let(:ticket) { FactoryGirl.create(:ticket, project: project) }
    
    context "for anonymous users" do
        let(:user) { nil }
        it { should_not permit_action :show }
        it { should_not permit_action :create }
    end

    context "for viewers" do
        before { assign_role!(user, :viewer, project) }

        it { should permit_action :show }
        it {should_not permit_action :create}
    end

context "for managers of anotgerproject" do
    before do
    assign_role!(user, :manager, FactoryGirl.create(:project))
    end
    it { should_not permit_action :show  }
    it { should_not permit_action :create}
    end

context "for editors of the project" do
    before do
        assign_role!(user, :editor, project)
    end
    it { should permit_action :create }
end

    context "for administrators" do
    let(:user) { FactoryGirl.create :user, :admin  }
    it { should permit_action :show  }
    it { should permit_action :create }
    end
    end
end
