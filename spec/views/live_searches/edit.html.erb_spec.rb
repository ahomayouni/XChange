require 'rails_helper'

RSpec.describe "live_searches/edit", type: :view do
  before(:each) do
    @live_search = assign(:live_search, LiveSearch.create!(
      :user_id => 1,
      :title => "MyString",
      :category => "MyText",
      :where => "MyString"
    ))
  end

  it "renders the edit live_search form" do
    render

    assert_select "form[action=?][method=?]", live_search_path(@live_search), "post" do

      assert_select "input[name=?]", "live_search[user_id]"

      assert_select "input[name=?]", "live_search[title]"

      assert_select "textarea[name=?]", "live_search[category]"

      assert_select "input[name=?]", "live_search[where]"
    end
  end
end
