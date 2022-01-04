require 'open-uri'
require 'watir'
require 'webdrivers'
require 'nokogiri'

# this needs to be manually set up
1000.upto(1050) do |n|
  url = "https://opensea.io/assets/0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d/#{n}"

  # this method  is incredibly slow, check Net::HTTP in the future
  browser = Watir::Browser.new
  browser.goto url
  parsed_page = Nokogiri::HTML(browser.html)
  image_url = parsed_page.css("img")[2].to_a[1][1] # bruh
  browser.close

  File.open("monkes/monke_#{n}.png", 'w+') do |file|
    image = URI.open(image_url)
    # this is weird, I can't just paste entire PNG into a single line even though it has newline escape characters
    # it works if i do it like this though
    image.read.split("\n").each do |line|
      file.puts line
    end
  end
end