class AttachmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

    def show?
        user.try(:admin?) || record.ticket.project.has_member?(user)
    end
  end
end
