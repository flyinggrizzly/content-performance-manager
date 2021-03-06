require 'rails_helper'
require 'features/pagination_spec_helper'

RSpec.feature "Organisations list", type: :feature do
  scenario "The user can see all the organisations" do
    create :organisation, title: "organisation title"

    visit organisations_path

    expect(page).to have_selector('tbody > tr', count: 1)
    expect(page).to have_selector('tbody tr:first-child td', text: "organisation title")
  end

  scenario "The user can navigate to an organisation detail page" do
    create :organisation, slug: "the-slug", title: "organisation title"

    visit organisations_path
    click_on "organisation title"

    expected_path = "/organisations/the-slug/content_items"
    expect(current_path).to eq(expected_path)
  end

  describe 'The user can navigate paged lists of organisations' do
    before do
      create_list :organisation, 3
    end

    it_behaves_like "a paginated list", "organisations/"
  end
end
