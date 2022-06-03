class MeetingsController < ApplicationController
  def index
    # @handovers = Handover.where(deliverer_id: current_user.id) + Handover.where(receiver_id: current_user.id)
    # @meetings = @handovers.map { |handover| handover.meeting }
    # @meetings = @meetings.uniq
    @meetings = policy_scope(Meeting)
    @handovers
  end
end
