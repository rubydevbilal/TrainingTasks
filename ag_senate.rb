require 'net/http'
require 'uri'
require "nokogiri"

m_d=[1,2,3,4,5,6,7,8,9,10,11,12]
m_t=["january","febraury","march","april","may","june","july","august","september","october","november","december"]
data_hash={}

uri = URI.parse("https://www.agriculture.senate.gov/newsroom/minority-news?pagenum_rs=1")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
request["Accept-Language"] = "en-US,en;q=0.9"
request["Cache-Control"] = "max-age=0"
request["Connection"] = "keep-alive"
request["Cookie"] = "s_inv=0; _ga=GA1.2.1706461467.1679478485; _gid=GA1.2.1951481453.1679478485; AMCVS_345E01D16312552B0A495FAC%40AdobeOrg=1; s_cc=true; AMCV_345E01D16312552B0A495FAC%40AdobeOrg=1176715910%7CMCIDTS%7C19439%7CMCMID%7C23823042258701673971369022511277005653%7CMCAAMLH-1680083285%7C6%7CMCAAMB-1680083285%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1679485685s%7CNONE%7CMCSYNCSOP%7C411-19446%7CvVersion%7C5.4.0; s_ips=980; s_tslv=1679479473022; s_nr30=1679479473027-New; s_sq=senatesenatorpublicglobalprod%3D%2526c.%2526a.%2526activitymap.%2526page%253Dwww.agriculture.senate.gov%25252Fnewsroom%25252Fminority-news%2526link%253D1%2525202%2525203%2525204%2525205%2525206%2525207%2525208%2525209%25252010%25252011%25252012%25252013%25252014%25252015%25252016%25252017%25252018%25252019%25252020%25252021%25252022%25252023%25252024%25252025%25252026%25252027%25252028%25252029%25252030%25252031%25252032%25252033%2526region%253Dnewsroom%2526pageIDType%253D1%2526.activitymap%2526.a%2526.c%2526pid%253Dwww.agriculture.senate.gov%25252Fnewsroom%25252Fminority-news%2526pidt%253D1%2526oid%253DfunctionselectClicked%252528%252529%25257Bthis.changed%25253Dtrue%25253B%25257D%2526oidt%253D2%2526ot%253DSELECT; _gat_gtag_UA_61463040_1=1; s_tp=4471; s_ppv=www.agriculture.senate.gov%252Fnewsroom%252Fminority-news%2C117%2C22%2C5236%2C2%2C10"
request["If-None-Match"] = "W/\"1d0d7-u8FPNfHIzr8M9eXs1ZsLI6/0gOQ\""
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

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

doc=Nokogiri::HTML(response.body)
doc.css("ul.PageList li").each{|article|
        title=article.css("h2.ArticleTitle").text.strip
        link=article.css("a.ArticleBlock__link")[0]["href"]

        uri = URI.parse(link)
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
        month=dex[0].downcase.strip()
        mon=0

        (1..12).each{|md|
        if month==m_t[md-1]
            mon=md
        end
        #   YYYY-MM-DD 
        }
        datetime="#{dex[2]}-#{mon}-#{dex[1]}"
        p=page_doc.css("div.js-press-release p")
        if p.count==1
            teaser="#{p.children[0].text.strip()}#{p.children[1].text.strip()}"
            article=p.children[-1].text.strip

        else
            articles_arr=[]
            article=p[0].text.strip()
            (1..p.count-1).each{|dat|
            articles_arr<<p[dat].text.strip()
        }
        article=articles_arr.join("\n")
        end

   puts datetime
  
  }



