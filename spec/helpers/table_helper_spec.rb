require 'rails_helper'

RSpec.describe TableHelper, type: :helper do
  describe '#sort_table_header', :sort_table_header do
    let(:organisation) { build(:organisation) }
    before { assign(:organisation, organisation) }

    let(:params_asc) { { order: 'asc', sort: attribute_name, organisation_slug: organisation.slug } }
    let(:params_desc) { { order: 'desc', sort: attribute_name, organisation_slug: organisation.slug } }

    let(:heading) { 'Last Updated' }
    let(:attribute_name) { 'public_updated_at' }

    subject { helper.sort_table_header(heading, attribute_name) }

    describe 'Accessibility' do
      context 'When the column is unsorted' do
        it 'sets aria-sort to none ' do
          expect(subject).to have_selector('[aria-sort=none]')
        end

        it 'sets screenreader text to sort asc' do
          expect(subject).to have_selector('.rm', text: ', sort ascending'.downcase)
        end
      end

      context 'When the column is sorted asc' do
        before { controller.params = params_asc }

        it 'sets aria-sort to ascending' do
          expect(subject).to have_selector('[aria-sort=ascending]')
        end

        it 'sets screenreader text to sort desc' do
          expect(subject).to have_selector('.rm', text: ', sort descending'.downcase)
        end
      end

      context 'When the column is sorted desc' do
        before { controller.params = params_desc }

        it 'sets aria-sort to descending' do
          expect(subject).to have_selector('[aria-sort=descending]')
        end

        it 'sets screenreader text to sort asc' do
          expect(subject).to have_selector('.rm', text: ', sort ascending'.downcase)
        end
      end
    end

    describe 'Sorting' do
      context 'When the column is unsorted' do
        it 'has a link to sort asc' do
          link_href = organisation_content_items_path(params_asc)

          expect(subject).to have_link(href: link_href)
        end
      end

      context 'When the column is sorted asc' do
        before { controller.params = params_asc }

        it 'has a link to sort desc' do
          link_href = organisation_content_items_path(params_desc)

          expect(subject).to have_link(href: link_href)
        end
      end

      context 'When the column is sorted desc' do
        before { controller.params = params_desc }

        it 'has a link to sort asc' do
          link_href = organisation_content_items_path(params_asc)

          expect(subject).to have_link(href: link_href)
        end
      end
    end
  end
end
