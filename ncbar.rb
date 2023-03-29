require 'net/http'
require 'uri'
require 'nokogiri'
require 'date'
require 'active_record'
require 'digest/md5'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'developer',
  password: 'Pakistan#123',
  database: 'db01'
)

class Details < ActiveRecord::Base
  self.table_name="lawyer_status_north_carolina"
  
  def self.add_new(data_dict)
    # Generate md5 hash of the record's values
    record_hash = Digest::MD5.hexdigest(data_dict.values.join)
    
    # Check if a record with the same hash already exists in the database
    if Details.where(record_hash: record_hash).exists?
      puts "Record already exists"
      return
    end
    
    # Insert the record and its hash into the database
    Details.create(data_dict.merge(record_hash: record_hash))
  end
end


BASE_URL="https://portal.ncbar.gov/"
uri = URI.parse("https://portal.ncbar.gov/Verification/search.aspx")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
request["Accept-Language"] = "en-US,en;q=0.9"
request["Connection"] = "keep-alive"
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
Cookie= response.header["set-cookie"]


doc=Nokogiri::HTML(response.body)
select_arr=doc.css("#ddSpecialization option")
select_arr.shift
select_arr=select_arr.map{|option|
  option.attr('value')
}


event_target=doc.css("input#__EVENTTARGET")[0]["value"]
event_argument=doc.css("input#__EVENTARGUMENT")[0]["value"]
view_state=doc.css("input#__VIEWSTATE")[0]["value"]
view_state_generator=doc.css("input#__VIEWSTATEGENERATOR")[0]["value"]
event_validation=doc.css("input#__EVENTVALIDATION")[0]["value"]

select_arr.each{|option_value|
  uri = URI.parse("https://portal.ncbar.gov/Verification/search.aspx")
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/x-www-form-urlencoded"
  request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
  request["Accept-Language"] = "en-US,en;q=0.9"
  request["Cache-Control"] = "max-age=0"
  request["Connection"] = "keep-alive"
  request["Cookie"] = Cookie
  request["Origin"] = "https://portal.ncbar.gov"
  request["Referer"] = "https://portal.ncbar.gov/Verification/search.aspx"
  request["Sec-Fetch-Dest"] = "document"
  request["Sec-Fetch-Mode"] = "navigate"
  request["Sec-Fetch-Site"] = "same-origin"
  request["Sec-Fetch-User"] = "?1"
  request["Upgrade-Insecure-Requests"] = "1"
  request["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
  request["Sec-Ch-Ua"] = "\"Google Chrome\";v=\"111\", \"Not(A:Brand\";v=\"8\", \"Chromium\";v=\"111\""
  request["Sec-Ch-Ua-Mobile"] = "?0"
  request["Sec-Ch-Ua-Platform"] = "\"Linux\""
  request.set_form_data(
    "__EVENTARGUMENT" => event_argument,
    "__EVENTTARGET" => event_target,
    "__EVENTVALIDATION" => event_validation,
    "__VIEWSTATE" => view_state,
    "__VIEWSTATEGENERATOR" => view_state_generator,
    "ctl00$Content$btnSubmit" => "Search",
    "ctl00$Content$ddJudicialDistrict" => "",
    "ctl00$Content$ddLicStatus" => "",
    "ctl00$Content$ddLicType" => "",
    "ctl00$Content$ddSpecialization" => option_value,
    "ctl00$Content$ddState" => "",
    "ctl00$Content$txtCity" => "",
    "ctl00$Content$txtFirst" => "",
    "ctl00$Content$txtLast" => "",
    "ctl00$Content$txtLicNum" => "",
    "ctl00$Content$txtMiddle" => "",
  )
  
  req_options = {
    use_ssl: uri.scheme == "https",
  }
  
  resp = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  STATUS_CODE=resp.code.to_i
  if STATUS_CODE==302
  
  uri = URI.parse("https://portal.ncbar.gov/Verification/results.aspx")
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
  request["Accept-Language"] = "en-US,en;q=0.9"
  request["Cache-Control"] = "max-age=0"
  request["Connection"] = "keep-alive"
  request["Cookie"] = Cookie
  request["Referer"] = "https://portal.ncbar.gov/Verification/search.aspx"
  request["Sec-Fetch-Dest"] = "document"
  request["Sec-Fetch-Mode"] = "navigate"
  request["Sec-Fetch-Site"] = "same-origin"
  request["Sec-Fetch-User"] = "?1"
  request["Upgrade-Insecure-Requests"] = "1"
  request["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
  request["Sec-Ch-Ua"] = "\"Google Chrome\";v=\"111\", \"Not(A:Brand\";v=\"8\", \"Chromium\";v=\"111\""
  request["Sec-Ch-Ua-Mobile"] = "?0"
  request["Sec-Ch-Ua-Platform"] = "\"Linux\""
  
  req_options = {
    use_ssl: uri.scheme == "https",
  }
  
  rp = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  
  main_doc= Nokogiri::HTML(rp.body)
  status=main_doc.css("table.table span.label-success").text.strip()


  arr_links=[]
  main_doc.css("table.table td").each{|td|
    a_tag=td.css("a")[0]
    if a_tag.class!=NilClass
      link=a_tag["href"]
      arr_links.push(link)
  
    end
  
  
  }
  
  arr_links.each{|record_link|
        new_url = URI.parse(BASE_URL+record_link)
          request = Net::HTTP::Get.new(new_url)
          request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
          request["Accept-Language"] = "en-US,en;q=0.9"
          request["Connection"] = "keep-alive"
          request["Cookie"] = Cookie
          request["Referer"] = "https://portal.ncbar.gov/Verification/results.aspx"
          request["Sec-Fetch-Dest"] = "document"
          request["Sec-Fetch-Mode"] = "navigate"
          request["Sec-Fetch-Site"] = "same-origin"
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
  
  
          data_dict={}
          details_doc=Nokogiri::HTML(response.body)
          name=details_doc.css("div.panel-heading").text.split(" - ")[0].strip()
          link_firm_name=details_doc.css("div.panel-heading").text.split(" - ")[1].strip()
          data_dict["name"]=name
          data_dict["url"]=BASE_URL+record_link
          data_dict["law_firm_name"]=link_firm_name
          
          details_doc.css("dl.dl-horizontal").each{|dl|
            dts=dl.css("dt").map{|dt|
              dt.text.gsub(/[#:]/,'').strip()
            }
            dds=dl.css("dd").map{|dd|
              dd.text.strip()
          }
          total=dts.count
          (0..total-1).each{|inc|
  
            data_dict[dts[inc]]=dds[inc]
  
          }
          
          }
        
          our_data= data_dict.except("Name","Status Date","Judicial District")
          mappings = {"name"=>"name","url"=>"link","law_firm_name"=>"law_firm_name","Address"=>"law_firm_address","City"=>"law_firm_city","Zip Code"=>"law_firm_zip","State"=>"law_firm_state",'Work Phone'=>'phone','Email' => 'email', 'Date Admitted' => 'date_admitted',"Bar"=>"bar","Board Certified In"=>"board_certified_in","Status"=>"status"}
          full_data=our_data.transform_keys(&mappings.method(:[]))
          wrong_format_date=full_data["date_admitted"]
          date = Date.strptime(wrong_format_date, '%m/%d/%Y')
          full_data["date_admitted"]=date.strftime('%Y-%m-%d')
          full_data["status"]=full_data["status"].split(" ")[0].strip

           Details.add_new(full_data)

          puts "Data Inserted for #{BASE_URL}#{record_link}"
  
  
  }

  puts "\n-----------Option #{option_value} Done -------------\n\n"
  
else
  puts "00000000000000000000000000000000000000000000000000000000000000"
  puts "No Data Found for Option #{option_value}"
  puts "00000000000000000000000000000000000000000000000000000000000000"
end

}
puts "_-_-_-_-_-_-_-_-_-_- Done _-_-_-_-_-_-_-_-_-_- "
