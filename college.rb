require 'net/http'
require 'uri'
require 'nokogiri'
require "byebug"
require "active_record"

ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    host: 'localhost',
    username: 'developer',
    password: 'Pakistan#123',
    database: 'db01'
  )
  
  class College_Table < ActiveRecord::Base
    self.table_name="national_college_scrape"
    def self.add_new(data_dict)
      College_Table.create(data_dict)
    end
   end
   Scrap_Dev="Muhammad Bilal"
["RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"].each{|state_name|
BASE_URL="https://nces.ed.gov/collegenavigator/?s=#{state_name}&pg="
uri=URI.parse("https://nces.ed.gov/collegenavigator/?s=#{state_name}")

request = Net::HTTP::Get.new(uri)
request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
request["Accept-Language"] = "en-US,en;q=0.9"
request["Cache-Control"] = "max-age=0"
request["Connection"] = "keep-alive"
request["Cookie"] = "ASP.NET_SessionId=n4ucfc3sidasbgirq2gpzi45; _ga=GA1.1.1505407272.1679312082; _ga=GA1.3.1505407272.1679312082; _gid=GA1.3.1075828241.1679312086; _ga_0EYJGC1REQ=GS1.1.1679312082.1.1.1679319306.0.0.0"
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
last_page_arr=doc.css("#ctl00_cphCollegeNavBody_ucResultsMain_divPagingControls strong")
if last_page_arr.count==0
  last_page=1
else
  last_page=last_page_arr[-1].text.to_i
end


(1..last_page).each{|pn|

uri = URI.parse("#{BASE_URL}#{pn}")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
request["Accept-Language"] = "en-US,en;q=0.9"
request["Cache-Control"] = "max-age=0"
request["Connection"] = "keep-alive"
request["Cookie"] = "ASP.NET_SessionId=n4ucfc3sidasbgirq2gpzi45; _ga=GA1.1.1505407272.1679312082; _ga=GA1.3.1505407272.1679312082; _gid=GA1.3.1075828241.1679312086; _ga_0EYJGC1REQ=GS1.1.1679312082.1.1.1679312606.0.0.0; _gat_GSA_ENOR0=1; _gat_GSA_ENOR1=1"
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
doc.css("table#ctl00_cphCollegeNavBody_ucResultsMain_tblResults td a").each{|inner_table|



    href=inner_table["href"]
    if(href).include?("id=")
        url="https://nces.ed.gov/collegenavigator/#{href}"
        data_hash={}

        uri = URI.parse(url)
        request = Net::HTTP::Get.new(uri)
        request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
        request["Accept-Language"] = "en-US,en;q=0.9"
        request["Cache-Control"] = "max-age=0"
        request["Connection"] = "keep-alive"
        request["Cookie"] = "ASP.NET_SessionId=n4ucfc3sidasbgirq2gpzi45; _ga=GA1.1.1505407272.1679312082; _ga=GA1.3.1505407272.1679312082; _gid=GA1.3.1075828241.1679312086; _ga_0EYJGC1REQ=GS1.1.1679312082.1.1.1679319306.0.0.0"
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
        col_name_el=doc.css("div.dashboard").css("span.headerlg")[0]
        college_name=col_name_el.text.strip()
        data_hash["college"]=college_name
        address_section=col_name_el.next_element.next_sibling
        if address_section.text.include?("All programs")
            complete_address= address_section.next_element.next_sibling.text
        else
            complete_address=address_section.text
        end
        add_array=complete_address.split(",")
        if add_array.count==3
          address,city,state_zip=add_array
        elsif add_array.count==4
          address="#{add_array[0]}#{add_array[1]}"
          city=add_array[2]
          state_zip=add_array[3]
        elsif add_array.count==5
          address="#{add_array[0]}#{add_array[1]}#{add_array[2]}"
          city=add_array[3]
          state_zip=add_array[4]
        elsif add_array.length==6
          address="#{add_array[0]}#{add_array[1]}#{add_array[2]}#{add_array[3]}"
          city=add_array[4]
          state_zip=add_array[5]
        elsif add_array.count==2
          address=""
          city,state_zip=add_array
        end
        state_zip_array=state_zip.split(" ")
        data_hash["adress"]=address
        data_hash["city"]=city
        if state_zip_array.count==3
          data_hash["state"]="#{state_zip_array[0]} #{state_zip_array[1]}"
          data_hash["zip"]=state_zip_array[2]
        else
          data_hash["state"]=state_zip_array[0]
          data_hash["zip"]=state_zip_array[1]
        end


        table=doc.css("table.layouttab tr").each{|tr|
          k=tr.css("td")[0].text.strip()
          v=tr.css("td")[1].text.strip()
          if k.include?("Related Institutions")
              
          else
            if(k.include?("Student"))
              v=v.split(" ")[0].gsub(/[,]/,'').to_i
            end
            data_hash[k.strip()]=v
          
        end
      }
        data_hash["Scrap_Dev"]=Scrap_Dev
        data_hash["datasource_url"]=url
        mappings = {"college"=>"College","adress"=>"address","city"=>"City","state"=>"State","zip"=>"Zip","General information:  "=>"phone_number","Website:  "=>"website","Type:  "=>"type_","Awards offered:  "=>"awards_offered","Campus setting:  "=>"campus_setting","Campus housing:  "=>"campus_housing","Student population:  "=>"student_population","Student-to-faculty ratio:  "=>"student_to_faculty_ratio","Scrap_Dev"=>"scrape_dev_name","datasource_url"=>"data_source_url"}
        full_data=data_hash.transform_keys(&mappings.method(:[]))
        College_Table.add_new(full_data)
        puts "Data Inserted for #{url}   STATE = #{state_name}"


    end
 
}
puts "---------------------------------------"
puts "          Done Page #{pn} & State=#{state_name}"
puts "---------------------------------------"
}
 puts  "\n\n-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
 puts  "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
 puts "|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|"
 puts "|                   Done STATE #{state_name}                           |"
 puts "|______________________________________________________________________|"
 puts  "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
 puts  "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-\n"



}