class NoticeResource < Webmachine::Resource
  # previous resource code here

  def generate_etag
    Digest::MD5.hexdigest(@notice.content)
  end

  def last_modified
    @notice.updated_at
  end
end
