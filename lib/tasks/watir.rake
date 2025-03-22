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

  def verify_profiles
    br = @browser
    Profile.all.each do |prof|
      puts "ID:#{prof.id}"
      puts prof.url
      br.goto prof.url
      location = br.element(tag_name: 'strong', class: 'location').text
      usr = br.element(tag_name: 'strong', class: 'user').text
      music = br.element(tag_name: 'strong', class: 'music').text
      img_src = br.element(tag_name: 'img', id: 'profile_image').attribute_values[:src]
      puts 'src:' + img_src.to_s
      puts 'text: ' + location.to_s + ' - ' + usr.to_s + ' - ' + music.to_s
      puts "===================="
      sleep 1
    end
  end

  def send_emails(instrument, tag)
    raise Exception.new('instrument was not specified') unless instrument
    br = @browser
    if tag 
      email = Email.where(tag: tag).first
      profiles = Profile.where.not(id: 
                         Profile.joins(:emails)
                         .where(emails: { tag:  }).select(:id)).where(instrument: instrument)
    else
      email = Email.where.missing(:mailings).first
      profiles = profiles.where(instrument: instrument)
    end   
    
    profiles.each do |prof|
      br.goto prof.url
      br.link(id: 'btn-contact').click
      br.text_field(id: 'contact-subject').set(email.subject)
      br.textarea(id: 'contact-message').set(email.body)
      br.button(type: 'submit').click
      Mailing.create(email: email, profile: prof)
      sleep 5
    end
  end

  def update_profiles
    br = @browser
    profiles = Profile.where("parsed IS NULL OR parsed = ?", false)
    profiles.each do |prof|
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
  desc "Update profiles"
  task update_data: :environment do
    upd = Updater.new
    sleep 2
    upd.sign_in
    upd.update_profiles
    sleep 10
  end

  task verify_data: :environment do
    upd = Updater.new
    sleep 2
    upd.sign_in
    upd.verify_profiles
    sleep 10
  end

  # use backslashses to send argument
  # rake watir:send_emails\['drums,chelmsford_drum'\]
  task :send_emails, [:instrument, :email_tag] => :environment do |t, args|
    tag = args[:email_tag].to_s
    instrument = args[:instrument]
    upd = Updater.new
    sleep 2
    upd.sign_in
    upd.send_emails(instrument, tag)
    sleep 10
  end

end
