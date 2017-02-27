class MetricBuilder
  def run_all(content_item_attributes)
    metrics = []
    all_metrics.each do |metric_klass|
      metrics.push metric_klass.new(content_item_attributes).run
    end
    metrics.reduce(:merge)
  end

private

  def all_metrics
    [
      Metrics::NumberOfPdfsMetric
    ]
  end
end
