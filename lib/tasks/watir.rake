require 'watir'
require 'webdrivers'

class Updater
  def initialize
    cred = Rails.application.credentials.music
    @browser = Watir::Browser.new :firefox
    @browser.goto cred[:website]
  end

  def sign_in
    cred = Rails.application.credentials.music
    br = @browser
    br.link(:id =>"sign-in").click

    email = br.text_field id: 'login-email'
    email.set cred[:email]
    pw = br.text_field id: 'login-password'
    pw.set cred[:pw]
    br.button(type: 'submit').click 
  end

  def update_profiles
    br = @browser
    Profile.all.each do |prof|
      br.goto prof.url
      location = br.element(tag_name: 'strong', class: 'location').text
      usr = br.element(tag_name: 'strong', class: 'user').text
      music = br.element(tag_name: 'strong', class: 'music').text
      img_src = br.element(tag_name: 'img', id: 'profile_image').attribute_values[:src]
      puts 'src:' + img_src.to_s
      puts 'text: ' + location.to_s + ' - ' + usr.to_s + ' - ' + music.to_s
      prof.parse_data(user: usr, music: music, location: location, image_url: img_src) unless prof.parsed
      sleep 1
    end
  end

end

namespace :watir do
  desc "TODO"
  task update_data: :environment do    

    upd = Updater.new    
    sleep 2
    upd.sign_in
    upd.update_profiles   
    puts 'click'
   
    sleep 10
  end

end
