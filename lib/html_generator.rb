require "erb_generator"

class HTMLGenerator < ERBGenerator
  def initialize(text=nil)
    if text != nil
      @text = (text.gsub("<%= yield %>", " ")).split(" ")
      @first_tag = @text[0].to_s
      @last_tag = @text[1].to_s
    else
      @first_tag = ""
      @last_tag = ""
    end
  end

  def wrapper(content)
    @first_tag + content + @last_tag
  end

  def section(text)
    template = "<section><%= section_text %></section>"
    options_hash = {:locals => {:section_text => text}}
    (@first_tag + (erb template, options_hash) + @last_tag)
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
    (@first_tag + (erb template, options_hash) + @last_tag)
  end

  def button(text, hsh={})
    template_no_class = "<button><%= button_text %></button>"
    template_with_class = "<button class='<%= class_hsh[:class] %>'><%= button_text %></button>"
    options_hash = {:locals => {:button_text => text, :class_hsh => hsh}}
    if hsh[:class] == nil
      (@first_tag + (erb template_no_class, options_hash) + @last_tag)
    else
      (@first_tag + (erb template_with_class, options_hash) + @last_tag)
    end
  end

end