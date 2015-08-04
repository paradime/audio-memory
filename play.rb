require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'pry'

base_url = "https://play.google.com/music/preview/pl/"
playlist_id = "AMaBXyny4_cMIcBwuI_l3hgC8UBi__3ZJHLIKuQtTavXSgvv1T0l7wMnLKJZMulH5t72PxkupIxcqjX61xLv4nXMRyVqIB3tlw=="
url = base_url + playlist_id
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
doc = Nokogiri::HTML(open( url))

row = doc.xpath("//tr")
output = ''
data_vals = row.xpath("//td")
title = doc.xpath("//div[@class='title fade-out']").text.tr_s(' ', '-')
out_file = File.new("#{title}.txt", 'w')
data_vals.each_with_index do |data, index|
    if data.text =~ /^\d+$/
        output += data
        song = data_vals[index+2]
        output += ": #{song.children[0].text} by #{song.children[1].text}" rescue ''
        out_file.puts output
        output = ''
    end
end
out_file.close
