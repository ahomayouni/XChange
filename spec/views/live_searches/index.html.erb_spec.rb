# require 'rails_helper'

# RSpec.describe "live_searches/index", type: :view do
#   before(:each) do
#     assign(:live_searches, [
#       LiveSearch.create!(
#         :user_id => 2,
#         :title => "Title",
#         :category => "MyText",
#         :where => "Where"
#       ),
#       LiveSearch.create!(
#         :user_id => 2,
#         :title => "Title",
#         :category => "MyText",
#         :where => "Where"
#       )
#     ])
#   end

#   it "renders a list of live_searches" do
#     render
#     assert_select "tr>td", :text => 2.to_s, :count => 2
#     assert_select "tr>td", :text => "Title".to_s, :count => 2
#     assert_select "tr>td", :text => "MyText".to_s, :count => 2
#     assert_select "tr>td", :text => "Where".to_s, :count => 2
#   end
# end
