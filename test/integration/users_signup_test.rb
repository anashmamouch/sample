require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  #Verify that after an invalid submition 
  #the number of records in the database did not change
  test "Invalid signup information" do
  	get signup_path
  	before_count = User.count
  	post users_path, user: {name: "",
              							email: "user@example",
              							password: "skrt",
              						  password_confirmation: "secret"}
  	after_count = User.count

  	assert_equal before_count, after_count
  	assert_template 'users/new'
  end

  test "Valid signup information" do
    get signup_path
    before_count = User.count
    post_via_redirect users_path, user: { name: "User Example",
                                          email: "user@example.com",
                                          password: "password",
                                          password_confirmation: "password"}
    after_count = User.count - 1

    assert_equal before_count, after_count
    
    assert_template 'users/show'
    assert is_logged_in?
  end
end
