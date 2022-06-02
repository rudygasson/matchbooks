class CopyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # user.admin? ? scope.all : scope.where(user: user)
      scope.where(user: user)
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def destroy?
    record.user == user
  end
end
