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

    end

    context "for viewers" do
        before { assign_role!(user, :viewer, project) }

        it { should permit_action :show }
    end

context "for managers of the project" do
    before do
    assign_role!(user, :manager, FactoryGirl.create(:project))
    end
    it { should_not permit_action :show  }
    end
    context "for administrators" do
    let(:user) { FactoryGirl.create :user, :admin  }
    it { should permit_action :show  }
    end
    end
end
