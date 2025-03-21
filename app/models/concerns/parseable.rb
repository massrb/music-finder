require 'open-uri'

module Parseable
  extend ActiveSupport::Concern

  def parse_data(data)
    mat = data[:location].match(/(.*),\s*(.*),\s*(\d{5})/)
    if mat
      town = mat[1]
      state = mat[2]
      zip = mat[3]
    end
    mat2 = data[:user].match(/\s*(\d+)\s*year old\s*(\S*)/i)
    if mat2
      age = mat2[1]
      gender = mat2[2]
    end
    self.update(music: data[:music], age: age, gender: gender, zip: zip, state: state, town: town, parsed: true)
    file = URI.open(data[:image_url])
    self.image.attach(io: file, filename: 'image.jpg', content_type: 'image/jpeg')    
    puts "age:" + age.to_s + ' gender:' + gender.to_s + ' zip:' + zip.to_s
  end

end