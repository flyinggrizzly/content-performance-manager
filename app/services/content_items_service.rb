class ContentItemsService
  def find_each(organisation_slug)
    raise 'missing block!' unless block_given?

    query = { filter_organisations: organisation_slug }
    fields = %w(link)

    Clients::SearchAPI.find_each(query: query, fields: fields) do |response|
      base_path = response.fetch(:link)
      content_item = Clients::ContentStore.find(base_path, attribute_names)

      puts build_metrics(content_item)
      puts content_item.fetch(:base_path)
      # TODO: merge enhanced metrics into content item - depends on DB changes 
      # yield metrics.reduce(content_item, :merge) if content_item
      cleanup_attributes(content_item)

      yield content_item if content_item
    end
  end

private

  def build_metrics(content_item)
    metrics = []
    all_metrics.each do |klass|
       metrics.push klass.new(content_item).build
    end
    metrics
  end

  def all_metrics
    [
      Metrics::NumberOfPdfsMetric
    ]
  end

  def cleanup_attributes(content_item)
    cleanable_attribute_names.each do |k|
      content_item.delete k
    end
  end

  def cleanable_attribute_names
    [
      :details
    ]
  end

  def attribute_names
    @names ||= %i(content_id description title public_updated_at document_type base_path details)
  end
end
