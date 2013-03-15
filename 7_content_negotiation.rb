class HelloResource < Webmachine::Resource
  def content_types_provided
    [['application/vnd.helloapp-v1+json', :to_representation_yay],
     ['application/vnd.helloapp-v2+json', :to_representation_nay]]
  end

  def to_representation_yay
    {yay: "Hello #{request.path_info[:id]}"}.to_json
  end

  def to_representation_nay
    {nay: "Hello #{request.path_info[:id]}"}.to_json
  end
end
