#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'rubygems'

product = ARGV[0]

url = "https://www.amazon.com/s?k= %s " % [product]
headers = {"User-Agent" => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Silk/44.1.54 like Chrome/44.0.2403.63 Safari/537.36',
    'Accept-Language' => 'en-US, en;q=0.5'}
page = URI.open(url, headers)
response = Nokogiri::HTML(page.read)

puts "Program started\n"

products_info = []
time = Time.now
file_name = "crawler-" + product + "-" + time.strftime("%m-%d-%Y-%H-%M-%S") + ".txt"

info = response.css('div.s-result-item').each do |element|  
    name = element.css("h2.a-size-mini.a-spacing-none.a-color-base.s-line-clamp-2 span.a-size-medium.a-color-base.a-text-normal").text.strip 
    price = element.css("span.a-price span.a-offscreen").text.strip.split("$", 0)[1]
    link = element.css("a.a-size-base.a-link-normal.s-link-style.a-text-normal").map { |link| link['href'] }

    if !name.to_s.strip.empty? && !price.to_s.strip.empty? && !link.to_s.strip.empty?
        products_info.append("Description: " + name.to_s + "\n")
        products_info.append("Price: " + price.to_s + "$\n")
        url2 = "https://www.amazon.com%s " % link
        File.open(file_name, "a") { |f| f.write url2 + "\n" }
        page2=URI.open(url2, headers)
        resp = Nokogiri::HTML(page2.read)
    
        products_info.append(resp.at_css('[id="mir-layout-DELIVERY_BLOCK-slot-PRIMARY_DELIVERY_MESSAGE_LARGE"]').text.strip.to_s + "\n")
        products_info.append("\n")
    end
end

puts products_info
