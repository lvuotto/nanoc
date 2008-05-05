module Nanoc::Filters
  class Haml < Nanoc::Filter

    identifiers :haml
    extensions  '.haml'

    def run(content)
      # Load requirements
      nanoc_require 'haml'

      # Get options
      options = @page.haml_options || {}

      # Create context
      context = ::Nanoc::Context.new(assigns)

      # Get result
      ::Haml::Engine.new(content, options).render(context, assigns)
    end

  end
end
