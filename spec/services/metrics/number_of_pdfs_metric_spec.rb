require 'rails_helper'

RSpec.describe Metrics::NumberOfPdfsMetric do
  subject { Metrics::NumberOfPdfsMetric }

  let(:content_with_pdfs) {
    {
      details: {
        documents: [
          '<div class=\"attachment-details\">\n<a href=\"link.pdf\">1</a>\n\n\n\n</div>',
          '<div class=\"attachment-details\">\n<a href=\"link.pdf\">1</a>\n\n\n\n</div>'
        ],
        final_outcome_documents: [
          '<div class=\"attachment-details\">\n<a href=\"link.pdf\">1</a>\n\n\n\n</div>'
        ]
      }
    }
  }

  let(:content_without_pdfs) {
    {
      details: {
        "documents" => ['<div class=\"attachment-details\">\n<a href=\"link.txt\">1</a>\n\n\n\n</div>']
      }
    }
  }

  let(:content_without_documents) {
    {
      details: {}
    }
  }

  it "returns the number of pdfs present" do
    expect(subject.new(content_with_pdfs).run).to eq(number_of_pdfs: 3)
  end

  it "returns 0 if no pdfs are present" do
    expect(subject.new(content_without_pdfs).run).to eq(number_of_pdfs: 0)
  end

  it "returns 0 if no documents are present" do
    expect(subject.new(content_without_documents).run).to eq(number_of_pdfs: 0)
  end
end
