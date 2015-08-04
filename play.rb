require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'pry'

url = "https://play.google.com/music/playlist/AMaBXyny4_cMIcBwuI_l3hgC8UBi__3ZJHLIKuQtTavXSgvv1T0l7wMnLKJZMulH5t72PxkupIxcqjX61xLv4nXMRyVqIB3tlw=="
url = "https://play.google.com/music/preview/pl/AMaBXyny4_cMIcBwuI_l3hgC8UBi__3ZJHLIKuQtTavXSgvv1T0l7wMnLKJZMulH5t72PxkupIxcqjX61xLv4nXMRyVqIB3tlw==?u=0#"
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
doc = Nokogiri::HTML(open( url))

row = doc.xpath("//tr")
output = ''
data_vals = row.xpath("//td")
data_vals.each_with_index do |data, index|

    if data.text =~ /^\d+$/
        output += data
        song = data_vals[index+2]
        output += ": #{song.children[0].text} by #{song.children[1].text}" rescue ''
        puts output
        output = ''
    end


    #if index % 6 == 0 
        #output += data
    #elsif index % 6 == 2
        #output += ": #{data.children[0].text} by #{data.children[1].text}" rescue ''
        #puts output
        #output = ''
    #end
end
