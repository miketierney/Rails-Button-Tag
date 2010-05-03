# Creates a true button element
# Place this in application_helper.rb to make it universally accessible

def button_tag(*args, &block)
  if block_given?
    options      = args.first || {}
    concat(button_tag(capture(&block), options))
  else
    name         = args.first
    options      = args.second || {}
    
    if options
      options = options.stringify_keys
      tag_options = tag_options(options)
    else
      tag_options = nil
    end
    
    "<button#{tag_options}>#{name}</button>"
  end
end
