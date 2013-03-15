class Notice < ActiveRecord::Base
end

class NoticeResource < Webmachine::Resource
  # as previously with GET, HEAD
end

class NoticeCollectionResource < Webmachine::Resource
  def content_types_provided
    [['application/json', :to_json]]
  end

  def to_json
    Notice.all.to_json
  end
end

Webmachine::Application.new do |app|
  app.add_route ["notices", :id], NoticeResource
  app.add_route ["notices"], NoticeCollectionResource
  app.run
end
