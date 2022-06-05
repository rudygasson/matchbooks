class MeetingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # sql_query = "deliverer_id WHERE :query OR receiver_id WHERE :query"
      scope.joins(:handovers).where(handovers: {deliverer_id: user.id}).or(scope.joins(:handovers).where(handovers: {receiver_id: user.id})).distinct
    end
  end

  def index?
    true
  end

  def create?
    true
  end
end
