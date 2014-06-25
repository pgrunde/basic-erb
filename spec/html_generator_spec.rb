require "spec_helper"

describe HTMLGenerator do
  def html_generator
    HTMLGenerator.new
  end

  def strip_whitespace(string)
    string.gsub(/\s+/, "")
  end

  describe "#section" do
    it "returns a string of html that has a section containing the text" do
      section_html = strip_whitespace(
        html_generator.section("this-is-the-body-of-a-section")
      )

      expect(section_html).to eq("<section>this-is-the-body-of-a-section</section>")
    end
  end

  describe "#unordered_list" do
    it "returns a string of html that contains the list" do
      list_html = strip_whitespace(
        html_generator.unordered_list(["item1", "item2", "item3"])
      )

      expect(list_html).to eq("<ul><li>item1</li><li>item2</li><li>item3</li></ul>")
    end
  end

  describe "#button" do
    it "returns a string of html that has a button with text" do
      button_html =
        html_generator.button("button-text")

      expect(button_html).to eq("<button>button-text</button>")
    end

    context "with a class attribute given" do
      it "returns the button with a class attribute" do
        button_html =
          html_generator.button("flashy-button", :class => "flashy_class")

        expect(button_html).to eq("<button class='flashy_class'>flashy-button</button>")
      end
    end
  end

  context "with a layout" do
    it "returns wraps all html in the layout by replacing yield" do
      html_generator = HTMLGenerator.new("<main><%= yield %></main>")
      html = strip_whitespace(
        html_generator.section("section_text")
      )
      expect(html).to eq("<main><section>section_text</section></main>")

      html_generator = HTMLGenerator.new("<div><%= yield %></div>")
      html = strip_whitespace(
        html_generator.unordered_list(["an-item"])
      )
      expect(html).to eq("<div><ul><li>an-item</li></ul></div>")

      html_generator = HTMLGenerator.new("<section><%= yield %></section>")
      html = strip_whitespace(
        html_generator.button("button-in-a-section")
      )
      expect(html).to eq("<section><button>button-in-a-section</button></section>")
    end
  end
end