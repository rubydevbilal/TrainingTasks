require 'net/http'
require 'uri'
require "nokogiri"

uri = URI.parse("https://www.agriculture.senate.gov/newsroom/rep/press/release/ranking-member-boozman-opening-statement-at-hearing-to-review-conservation-and-forestry-titles-of-the-farm-bill")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
request["Accept-Language"] = "en-US,en;q=0.9"
request["Cache-Control"] = "max-age=0"
request["Connection"] = "keep-alive"
request["Cookie"] = "s_inv=0; _ga=GA1.2.1706461467.1679478485; _gid=GA1.2.1951481453.1679478485; AMCVS_345E01D16312552B0A495FAC%40AdobeOrg=1; s_cc=true; AMCV_345E01D16312552B0A495FAC%40AdobeOrg=1176715910%7CMCIDTS%7C19439%7CMCMID%7C23823042258701673971369022511277005653%7CMCAAMLH-1680083285%7C6%7CMCAAMB-1680083285%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1679485685s%7CNONE%7CMCSYNCSOP%7C411-19446%7CvVersion%7C5.4.0; s_sq=%5B%5BB%5D%5D; s_tslv=1679480589956; s_nr30=1679480589958-New; s_ips=980; s_tp=2484; s_ppv=www.agriculture.senate.gov%252Fnewsroom%252Frep%252Fpress%252Frelease%252Franking-member-boozmans-opening-statement-at-hearing-entitled-farm-bill-2023-nutrition-programs%2C48%2C39%2C1181%2C1%2C2"
request["If-None-Match"] = "W/\"17729-vzgWeFI7Ru9FvIi+ZsLdlrAlFWM\""
request["Sec-Fetch-Dest"] = "document"
request["Sec-Fetch-Mode"] = "navigate"
request["Sec-Fetch-Site"] = "none"
request["Sec-Fetch-User"] = "?1"
request["Upgrade-Insecure-Requests"] = "1"
request["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
request["Sec-Ch-Ua"] = "\"Google Chrome\";v=\"111\", \"Not(A:Brand\";v=\"8\", \"Chromium\";v=\"111\""
request["Sec-Ch-Ua-Mobile"] = "?0"
request["Sec-Ch-Ua-Platform"] = "\"Linux\""

req_options = {
  use_ssl: uri.scheme == "https",
}

resp= Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end
m_d=[1,2,3,4,5,6,7,8,9,10,11,12]
m_t=["january","febraury","march","april","may","june","july","august","september","october","november","december"]
page_doc=Nokogiri::HTML(resp.body)
dex=page_doc.css("time").children[-1].text.strip()
if dex.include?("th,")
    dex=dex.gsub("th,","")
elsif dex.include?("st,")
    dex=dex.gsub("st,","")
elsif dex.include?("rd,")
    dex=dex.gsub("rd,","")
end
dex=dex.split(" ")
 mon=0
#  puts dex.inspect
(1..12).each{|md|
  if month==m_t[md-1]
    mon=md
  end
#   YYYY-MM-DD 
}
puts  "#{dex[2]}-#{mon}-#{dex[1]}"