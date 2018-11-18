require 'rails_helper'

RSpec.describe "live_searches/new", type: :view do
  before(:each) do
    assign(:live_search, LiveSearch.new(
      :user_id => 1,
      :title => "MyString",
      :category => "MyText",
      :where => "MyString"
    ))
  end

  it "renders new live_search form" do
    render

    assert_select "form[action=?][method=?]", live_searches_path, "post" do

      assert_select "input[name=?]", "live_search[user_id]"

      assert_select "input[name=?]", "live_search[title]"

      assert_select "textarea[name=?]", "live_search[category]"

      assert_select "input[name=?]", "live_search[where]"
    end
  end
end
