require "nokogiri"
require "open-uri"
require "uri"

class Allegro
  def initialize url
    raise ArgumentError.new("Invalid URL") unless url =~ URI::regexp

    @url = url
    @response = Nokogiri::HTML open(url)
  end

  def title
    @title ||= @response.css("span#productTitle").text
  end

  def price
    prices_array = @response.css("div#tmmSwatches ul li a span").map{|node| node.text.gsub("\n\t", "").strip}.uniq.reject{|element| element == "from"}
    @price ||= Hash[prices_array.each_slice(2).to_a]
  end
end