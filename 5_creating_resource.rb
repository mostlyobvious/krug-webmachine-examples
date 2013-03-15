class Notice < ActiveRecord::Base
end

class NoticeCollectionResource
  # as previous
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
    response.headers['Location'] = "/notice/#{@notice.id}"
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def from_json
    Notice.create(JSON.parse(request.body.to_s))
  end

  def allowed_methods
    if request.path_info.has_key?(:id)
      %w(HEAD GET)
    else
      %w(POST)
    end
  end

  def allow_missing_post?
    !request.path_info.has_key?(:id)
  end

  def post_is_create?
    !request.path_info.has_key?(:id)
  end

  def create_path
    "/dummy"
    # path for the new resource, used in Location header
  end
end

Webmachine::Application.new do |app|
  app.add_route ["notices", :id], NoticeResource
  app.add_route ["notices"], ->(request) { request.method == 'POST' }, NoticeResource
  app.add_route ["notices"], NoticeCollectionResource
  app.run
end
