require 'webmachine'

class HelloResource < Webmachine::Resource
  def allowed_methods
    ['GET', 'HEAD']
  end

  def content_types_provided
    [['text/html', :to_html]]
  end

  def to_html
    "<html><body>Hello #{request.path_info[:name]}</body></html>"
  end
end

Webmachine::Application.new do |app|
  app.add_route ["hello", :name], HelloResource
  app.run
end
