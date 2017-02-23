module Metrics
  class NumberOfPdfsMetric
    PDF_XPATH = "//*[contains(@class, 'attachment-details')]//a[contains(@href, '.pdf')]".freeze

    def initialize(content_item)
      @content_item = content_item
    end

    def build
      documents_string = extract_documents
      documents = parse documents_string
      { number_of_pdfs: number_of_pdfs(documents) }
    end

  private

    def extract_documents
      if @content_item[:details].key?("documents") 
        @content_item[:details]["documents"].join('')
      else
        ''
      end
    end

    def parse(string)
      Nokogiri::HTML(string)
    end

    def number_of_pdfs(html_fragment)
      html_fragment.xpath(PDF_XPATH).length
    end
  end
end
