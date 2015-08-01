require 'rails_helper'
require 'spec_helper'

RSpec.feature 'User sign up:', :type => :feature do

  describe 'User submits valid form values' do
    it 'persists user to db' do
      visit '/users/sign_up'
      fill_in 'user_email', :with => 'drdre@publichealth.org'
      fill_in 'user_username', :with => 'drdrizzle'
      fill_in 'user_name', :with => 'user_name'
      fill_in 'user_password', :with => 'straightouttacompton'
      fill_in 'user_password_confirmation', :with => 'straightouttacompton'
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  describe 'Invalid submission: password confirmation doesnt match' do
    it 'displays error message to user' do
      visit '/users/sign_up'
      fill_in 'user_email', :with => 'timmytacuba@example.com'
      fill_in 'user_username', :with => 'therealtimmy'
      fill_in 'user_name', :with => 'TimmyMCgee'
      fill_in 'user_password', :with => 'greatpassword'
      fill_in 'user_password_confirmation', :with => 'notgreatpassword'
      click_button 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  describe 'Email does not have @ symbol' do
    it ': rejects form submission' do
      visit '/users/sign_up'
      fill_in 'user_email', :with => 'timmytacuba'
      fill_in 'user_username', :with => 'therealtimmy'
      fill_in 'user_name', :with => 'timmy'
      fill_in 'user_password', :with => 'greatpassword'
      fill_in 'user_password_confirmation', :with => 'greatpassword'
      click_button 'Sign up'
      expect(page).to have_content('Sign up')
    end
  end

  describe 'Form submission has multiple errors' do
    it 'displays each error to user' do
      visit ('/users/sign_up')
      fill_in 'user_email', :with => 'timmytacuba@gmail.com'
      fill_in 'user_name', :with => 'timmy'
      fill_in 'user_password', :with => 'greatpassword'
      fill_in 'user_password_confirmation', :with => 'notmatch'
      click_button 'Sign up'
      expect(page).to have_text("Password confirmation doesn't match Password")
      expect(page).to have_text("Username can't be blank")
      expect(page).to have_text("Username is too short (minimum is 5 characters")
    end
  end
end
