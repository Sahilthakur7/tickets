require 'rails_helper'

describe ProjectPolicy do

  let(:user) { User.new }

  subject { ProjectPolicy }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "policy_scope" do
      subject { Pundit.policy_scope(user, Project) }

      let!(:project) { FactoryGirl.create :project }
      let(:user) { FactoryGirl.create :user }

      it "is empty for anonymous users" do
          expect(Pundit.policy_scope(nil,Project)).to be_empty
      end

      it "inclludes a project a user is allowed to view" do
          assign_role!(user, :viewer, project)
          expect(subject).to include(project)
      end
  end

  permissions :show? do
      let(:user) { FactoryGirl.create :user }
      let(:project) { FactoryGirl.create :project }

      it "blocks anonymous users" do
          expect(subject).not_to permit(nil,project)
      end

      it "allows viewers of the project" do
          assign_role!(user, :viewer, project)
          expect(subject).to permit(user,project)
      end


      it "allows editorsof the project" do
          assign_role!(user, :editor , project)
          expect(subject).to permit(user,project)
      end

      it "allows managers of the project" do
          assign_role!(user, :manager, project)
          expect(subject).to permit(user,project)
      end

      it "doesn't allow users assigned to other projects" do
          other_project = FactoryGirl.create :project
          assign_role!(user, :manager, other_project)
          expect(subject).not_to permit(user,project)
      end

  end

  permissions :update? do
      let(:user) { FactoryGirl.create :user }
      let(:project) { FactoryGirl.create :project }

      it "blocks anonymous users" do
          expect(subject).not_to permit(nil,project)

      end

      it "doesnt allow viewers to edit" do
          assign_role!(user, :viewer, project)
          expect(subject).not_to permit(user, project)

      end

      it "allows managers of the project to" do
          assign_role!(user, :manager, project)
          expect(subject).to permit(user, project)
      end

      it "allows admins to" do
          admin = FactoryGirl.create :user,:admin
          expect(subject).to permit(admin,project)
      end
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
