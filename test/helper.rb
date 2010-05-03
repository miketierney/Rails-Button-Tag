require 'rubygems'
require 'erb'

require 'active_support'
# require 'action_pack'

require 'test/unit'
require '../button_helper.rb'

# Including some Rails-supporting methods, since I'm assuming that this code will be used in a Rails environment, but I don't want to include more code than necessary. YMMV.

# From actionpack/lib/action_view/helpers/tag_helper.rb v 2.3.4

BOOLEAN_ATTRIBUTES = %w(disabled readonly multiple checked autobuffer
                           autoplay controls loop selected hidden scoped async
                           defer reversed ismap seemless muted required
                           autofocus novalidate formnovalidate open).to_set

BOOLEAN_ATTRIBUTES.merge(BOOLEAN_ATTRIBUTES.map {|attr| attr.to_sym })

# Returns an escaped version of +html+ without affecting existing escaped entities.
#
# ==== Examples
#   escape_once("1 < 2 &amp; 3")
#   # => "1 &lt; 2 &amp; 3"
#
#   escape_once("&lt;&lt; Accept & Checkout")
#   # => "&lt;&lt; Accept &amp; Checkout"
def escape_once(html)
  ActiveSupport::Multibyte.clean(html.to_s).gsub(/[\"><]|&(?!([a-zA-Z]+|(#\d+));)/) { |special| ERB::Util::HTML_ESCAPE[special] }
end

def tag_options(options, escape = true)
  unless options.blank?
    attrs = []
    if escape
      options.each_pair do |key, value|
        if BOOLEAN_ATTRIBUTES.include?(key)
          attrs << %(#{key}="#{key}") if value
        else
          attrs << %(#{key}="#{escape_once(value)}") if !value.nil?
        end
      end
    else
      attrs = options.map { |key, value| %(#{key}="#{value}") }
    end
    " #{attrs.sort * ' '}" unless attrs.empty?
  end
end