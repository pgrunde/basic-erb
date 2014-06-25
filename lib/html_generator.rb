require "erb_generator"

class HTMLGenerator < ERBGenerator
  def initialize(text=nil)
    @wrapper = text
  end

  def wrapper(erb_output)
    if @wrapper
      template = @wrapper
      options_hash = {:locals => {:yield_replace => erb_output}}
      erb template, options_hash
    else
      erb_output
    end
  end

  def section(text)
    template = "<section><%= section_text %></section>"
    options_hash = {:locals => {:section_text => text}}
    output = erb template, options_hash
    wrapper(output)
  end

  def unordered_list(items)
    template = <<-TEMPLATE
<ul>
  <% html_items.each do |item| %>
    <li><%= item %></li>
  <% end %>
</ul>
    TEMPLATE
    options_hash = {:locals => {:html_items => items}}
    output = erb template, options_hash
    wrapper(output)
  end

  def button(text, hsh={})
    template_no_class = "<button><%= button_text %></button>"
    template_with_class = "<button class='<%= class_hsh[:class] %>'><%= button_text %></button>"
    options_hash = {:locals => {:button_text => text, :class_hsh => hsh}}
    if hsh[:class] == nil
      output = erb template_no_class, options_hash
      wrapper(output)
    else
      output = erb template_with_class, options_hash
      wrapper(output)
    end
  end

end