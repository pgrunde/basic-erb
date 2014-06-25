require "erb_generator"

class HTMLGenerator < ERBGenerator
  def initialize(text=nil)
    @wrapper = text
  end

  def section(text)
    template = "<section><%= section_text %></section>"
    options_hash = {:locals => {:section_text => text}, :layout => @wrapper}
    erb template, options_hash
  end

  def unordered_list(items)
    template = <<-TEMPLATE
<ul>
  <% html_items.each do |item| %>
    <li><%= item %></li>
  <% end %>
</ul>
    TEMPLATE
    options_hash = {:locals => {:html_items => items}, :layout => @wrapper}
    erb template, options_hash
  end

  def button(text, hsh={})
    template_no_class = "<button><%= button_text %></button>"
    template_with_class = "<button class='<%= class_hsh[:class] %>'><%= button_text %></button>"
    options_hash = {:locals => {:button_text => text, :class_hsh => hsh}, :layout => @wrapper}
    if hsh[:class] == nil
      erb template_no_class, options_hash
    else
      erb template_with_class, options_hash
    end
  end

end