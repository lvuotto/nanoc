module Nanoc3

  module Errors # :nodoc:

    # Generic error. Superclass for all nanoc-specific errors.
    class GenericError < ::RuntimeError ; end

    # Error that is raised when a site is loaded that uses a data source with
    # an unknown identifier.
    class UnknownDataSourceError < GenericError ; end

    # Error that is raised when a site is loaded that uses a data source with
    # an unknown identifier.
    class UnknownRouterError < GenericError ; end

    # Error that is raised during site compilation when a page uses a layout
    # that is not present in the site.
    class UnknownLayoutError < GenericError ; end

    # Error that is raised during site compilation when a page uses a filter
    # that is not known.
    class UnknownFilterError < GenericError ; end

    # Error that is raised during site compilation when a layout is compiled
    # for which the filter cannot be determined. This is similar to the
    # UnknownFilterError, but specific for filters for layouts.
    class CannotDetermineFilterError < GenericError ; end

    # Error that is raised during site compilation when a page (directly or
    # indirectly) includes its own page content, leading to endless recursion.
    class RecursiveCompilationError < GenericError ; end

    # Error that is raised when a certain function or feature is used that is
    # no longer supported by nanoc.
    class NoLongerSupportedError < GenericError ; end

    # Error that is raised when no rules file can be found in the current
    # working directory.
    class NoRulesFileFoundError < GenericError ; end

    # Error that is raised when no compilation rule that can be applied to the
    # current page can be found.
    class NoMatchingRuleFoundError < GenericError ; end

  end

end