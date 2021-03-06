module Nanoc
  class ItemView < ::Nanoc::View
    include Nanoc::DocumentViewMixin

    # Returns the compiled content.
    #
    # @param [String] rep The name of the representation
    #   from which the compiled content should be fetched. By default, the
    #   compiled content will be fetched from the default representation.
    #
    # @param [String] snapshot The name of the snapshot from which to
    #   fetch the compiled content. By default, the returned compiled content
    #   will be the content compiled right before the first layout call (if
    #   any).
    #
    # @return [String] The content of the given rep at the given snapshot.
    def compiled_content(rep: :default, snapshot: :pre)
      reps.fetch(rep).compiled_content(snapshot: snapshot)
    end

    # Returns the item path, as used when being linked to. It starts
    # with a slash and it is relative to the output directory. It does not
    # include the path to the output directory. It will not include the
    # filename if the filename is an index filename.
    #
    # @param [String] rep The name of the representation
    #   from which the path should be fetched. By default, the path will be
    #   fetched from the default representation.
    #
    # @param [Symbol] snapshot The snapshot for which the
    #   path should be returned.
    #
    # @return [String] The item’s path.
    def path(rep: :default, snapshot: :last)
      reps.fetch(rep).path(snapshot: snapshot)
    end

    # Returns the children of this item. For items with identifiers that have
    # extensions, returns an empty collection.
    #
    # @return [Enumerable<Nanoc::ItemView>]
    def children
      unless unwrap.identifier.legacy?
        raise Nanoc::Int::Errors::CannotGetParentOrChildrenOfNonLegacyItem.new(unwrap.identifier)
      end

      children_pattern = Nanoc::Int::Pattern.from(unwrap.identifier.to_s + '*/')
      children = @context.items.select { |i| children_pattern.match?(i.identifier) }

      children.map { |i| Nanoc::ItemView.new(i, @context) }.freeze
    end

    # Returns the parent of this item, if one exists. For items with identifiers
    # that have extensions, returns nil.
    #
    # @return [Nanoc::ItemView] if the item has a parent
    #
    # @return [nil] if the item has no parent
    def parent
      unless unwrap.identifier.legacy?
        raise Nanoc::Int::Errors::CannotGetParentOrChildrenOfNonLegacyItem.new(unwrap.identifier)
      end

      parent_identifier = '/' + unwrap.identifier.components[0..-2].join('/') + '/'
      parent = @context.items[parent_identifier]

      parent && Nanoc::ItemView.new(parent, @context).freeze
    end

    # @return [Boolean] True if the item is binary, false otherwise
    def binary?
      unwrap.content.binary?
    end

    # Returns the representations of this item.
    #
    # @return [Nanoc::ItemRepCollectionView]
    def reps
      Nanoc::ItemRepCollectionView.new(@context.reps[unwrap], @context)
    end

    # @api private
    def raw_filename
      unwrap.content.filename
    end
  end
end
