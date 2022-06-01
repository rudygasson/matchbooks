class CopyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # user.admin? ? scope.all : scope.where(user: user)
      scope.where(user: user)
    end

    def index?
      record.user == user
    end

    def new?
      true
    end

    def create?
      true
    end

    def destroy?
      record.user == user
      # true
    end
  end
end
