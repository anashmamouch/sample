require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
 def setup
 	@user = User.new(name: "Anas", email:"anas@gmail.com", password:"secret", password_confirmation: "secret")
 end

 test "user should be valid" do
 	assert @user.valid?
 end

 test "name should be present" do
 	@user.name = "   "
 	assert_not @user.valid?
 end

 test "email should be present" do
 	@user.email = "  "
 	assert_not @user.valid?
 end

 test "name should not be too long" do
 	@user.name = "a"*31
 	assert_not @user.valid?
 end
 
 test "email should not be too long" do
 	@user.email = "e"*256
 	assert_not @user.valid?
 end

 test "email validation should accept valid addresses" do
 	valid_addresses = %w[user@example.com USER@bar.COM  A_US-R@foo.bar.org
 	                   first.last@foo.jp  alice+bob@baz.cn]
 	valid_addresses.each do |valid_address|
 		@user.email = valid_address
 		assert @user.valid?, " #{valid_address.inspect} should be valid"

 	end
 end

 test "email validation should reject invalid addresses" do
 	invalid_addresses = %w[user@example,com user_at_foo.org user@example.
 	                       foo@baz_bar.com foo@bar+baz.com]

 	invalid_addresses.each do |invalid_addess|
 		@user.email = invalid_addess
 		assert_not @user.valid?, " #{invalid_addess.inspect} should be invalid"
 	end
 end
 
 test "email should be unique" do
 	duplicate_user = @user.dup
 	duplicate_user.email = @user.email.upcase
 	@user.save
 	assert_not duplicate_user.valid?
 end

 test "password should have minimum length" do 
 	@user.password = @user.password_confirmation = "p"*5
 	assert_not @user.valid?

 end

 test "email should be saved in downcase" do
 	

 end

 test "authenticate? should return false for a user with a nil digest" do
 	assert_not @user.authenticate?('')
 end	
end
