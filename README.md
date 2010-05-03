#About

This is just a stupid little snippet of code that allows you to add `button` elements to your Rails application without having to either manually code the HTML, or do weird `content_tag` trickery.

You can use it just like you do with `link_to`:

    <%= button_tag 'Sign In!', :type => 'submit', :class => 'sign_in' %>
    #=> <button type="submit" class="sign_in">Sign In!</button>

It is also smart enough to take a block:

    <% button_tag :class => 'button' do %>
      <span><span>Button in a Block</span></span>
    <% end %>
    #=> <button class="button"><span><span>Button in a Block</span></span></button>


# Testing
The testing support for this is sketchy ... the tests *will* run (and pass), but until I figure out a way to not include **all** of the Rails methods in the test suite, it's going to be a little sketchy.

You can drop the following specs in to your application if you're using RSpec, and that can get you started with feeling good that the code will work.

    describe "button_tag" do
      it "should render a button" do
        template = <<-EOF
          <%= button_tag('Button Tag', :type => 'submit') %>
        EOF
        eval_erb(template).should have_tag('button[type="submit"]', :content => 'Button Tag')
      end
      it "should render a button when given a block" do
        template = <<-EOF
          <% button_tag :type => 'submit' do %>
            <span>Button Tag</span>
          <% end %>
        EOF
        eval_erb(template).should have_tag('button[type="submit"]')
        eval_erb(template).should have_tag('span', :content => 'Button Tag')
      end
    end

Patches are, of course, more than welcome.

# Assumptions
You're using Rails. Likely won't work, otherwise.

Also, I've only tested this against 2.3.5. Any other versions are untested, though it's based on existing Rails code that's been in place for a while, so chances are good that it'll work, but consider yourself warned.

# Prior Art
This is largely based off of the [`link_to`](http://apidock.com/rails/ActionView/Helpers/UrlHelper/link_to) the method in Rails, and I've just modified it to be more relevant to the existence of buttons. So, credit is due primarily to the author(s) of that particular method.

# Licensing
Use and re-use as much as you want.