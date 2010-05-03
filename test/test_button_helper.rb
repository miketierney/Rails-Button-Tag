require 'helper'

class TestButtonHelper < Test::Unit::TestCase
  def test_button_rendering
    template = ERB.new <<-EOF
      <%= button_tag('Button Tag', :type => 'submit') %>)
    EOF
    
    assert_match(/<button type=\"submit\">Button Tag<\/button>/, template.result)
  end
  
  # def test_button_rendering_with_block
  #   template = ERB.new <<-EOF
  #     <% button_tag :type => 'submit' do %>
  #       <span>Button Tag</span>
  #     <% end %>
  #   EOF
  # 
  #   assert_match(/<button type=\"submit\"><span>Button Tag<span><\/button>/, template.result)
  # end
end