require "rails_helper"

RSpec.describe MetricBuilder do
  describe "#run_all" do
    let(:metrics) { { m1: 1 } }

    it "calls each metric class once" do
      expect_any_instance_of(Metrics::NumberOfPdfsMetric).to receive(:run).exactly(1).times.and_return(metrics)

      subject.run_all({})
    end

    it "returns a merged hash of metrics" do
      allow_any_instance_of(Metrics::NumberOfPdfsMetric).to receive(:run).and_return(metrics)
      result = subject.run_all({})

      expect(result).to eq(metrics)
    end
  end
end
