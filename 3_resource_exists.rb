class Notice < ActiveRecord::Base
end

class NoticeResource < Webmachine::Resource
  def content_types_provided
    [['application/json', :to_json]]
  end

  def resource_exists?
    @notice = Notice.where(id: request.path_info[:id]).first
    @notice.present?
  end

  def to_json
    @notice.to_json
  end
end

Webmachine::Application.new do |app|
  app.add_route ["notices", :id], NoticeResource
  app.run
end
