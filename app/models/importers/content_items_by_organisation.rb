module Importers
  class ContentItemsByOrganisation
    def run(slug)
      organisation = Organisation.find_by(slug: slug)
      ContentItemsService.new.find_each(slug) do |content_item_attributes|
        metrics = MetricBuilder.new.run_all(content_item_attributes)
        ContentItem.create_or_update!(metrics.merge(content_item_attributes), organisation)
      end
    end
  end
end
