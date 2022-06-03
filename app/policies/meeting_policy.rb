class MeetingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      sql_query = "deliverer_id WHERE :query OR receiver_id WHERE :query"
      scope.joins(:handover).where(sql_query, query: "#{user.id}")
    end
  end

  def index?
    true
  end
end
