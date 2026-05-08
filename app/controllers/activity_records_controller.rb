class ActivityRecordsController < ApplicationController
  def index
    @activity_records = current_user.activity_records
  end
end
