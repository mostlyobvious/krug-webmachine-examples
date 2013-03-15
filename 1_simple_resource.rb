require 'webmachine'

class HelloResource < Webmachine::Resource
  def to_html
    "<html><body>Hello #{request.path_info[:name]}</body></html>"
  end
end

Webmachine::Application.new do |app|
  app.add_route ["hello", :name], HelloResource
  app.run
end
