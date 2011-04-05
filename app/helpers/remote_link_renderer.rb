# app/helpers/remote_link_renderer.rb

class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  def prepare(collection, options, template)
    @remote = options.delete(:remote) || {}
    super
  end

protected
  def page_link(page, text, attributes = {})
    puts "TEST123"
    puts page
    puts "---"
    puts text
    @template.link_to_remote(text, {:url => url_for(page), :method => :get}.merge(@remote), attributes)
  end
end