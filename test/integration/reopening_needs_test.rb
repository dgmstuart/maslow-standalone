require_relative '../integration_test_helper'

class ReopeningNeedsTest < ActionDispatch::IntegrationTest
  def need_hash
    {
      "id" => "100002",
      "role" => "parent",
      "goal" => "apply for a primary school place",
      "benefit" => "my child can start school",
      "organisations" => [],
      "duplicate_of" => "100001"
    }
  end

  setup do
    login_as(stub_user)
    need_api_has_organisations({})
    need_api_has_needs([need_hash])  # For need list
    need_api_has_need(need_hash)  # For individual need
    content_api_has_artefacts_for_need_id("100002", [])
    @api_url = Plek.current.find('need-api') + '/needs/100002'
  end

  context "reopening a need that was closed as a duplicate" do
    should "be able to reopen a need" do
      request_body = {
        "author" => {
          "name" => stub_user.name,
          "email" => stub_user.email,
          "uid" => stub_user.uid
        }
      }
      delete_request = stub_request(:delete, @api_url+'/closed').with(:body => request_body.to_json)

      visit "/needs"
      click_on "100002"

      # re-stub request ready for reopen completing and the need is re-shown
      need_api_has_need(need_hash.merge("duplicate_of" => nil))

      click_on_first_button "Reopen"
      assert_requested delete_request

      assert page.has_no_content?("This need is closed as a duplicate of 100001")
      assert page.has_no_link?("100001", href: "/needs/100001")
      assert page.has_link?("Edit")
    end

    should "show an error if there's a problem reopening the need" do
      request = stub_request(:delete, @api_url+'/closed').to_return(status: 422)

      visit "/needs"
      click_on "100002"
      click_on "Reopen"

      assert page.has_content?("There was a problem reopening the need")
      assert page.has_content?("This need is closed as a duplicate of 100001")
      assert page.has_link?("100001", href: "/needs/100001")
      assert page.has_no_link?("Edit")
    end
  end
end