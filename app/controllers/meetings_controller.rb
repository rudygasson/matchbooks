class MeetingsController < ApplicationController
  def index
    @meetings = policy_scope(Meeting)
    @handovers = []
    @meetings.each do |meeting|
      @handovers.push(meeting.handovers)
    end
  end
end
