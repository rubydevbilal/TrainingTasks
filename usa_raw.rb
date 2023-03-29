require 'net/http'
require 'uri'
require "nokogiri"
require "httparty"
require "active_record"

ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    host: 'localhost',
    username: 'developer',
    password: 'Pakistan#123',
    database: 'db01'
  )
  
  class Details < ActiveRecord::Base
    self.table_name="usa_raw"
    def self.add_new(data_dict)
     Details.create(data_dict)
    end
   end

# Getting Last Page Number 
muri = URI.parse("https://revenue.delaware.gov/business-license-search/")
    req = Net::HTTP::Get.new(muri)
    req["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
    req["Accept-Language"] = "en-US,en;q=0.9"
    req["Cache-Control"] = "max-age=0"
    req["Connection"] = "keep-alive"
    req["Cookie"] = "ROUTEID=.2; BIGipServer~DTI~proxy-geo-wordpress=4179173292.47873.0000; _gid=GA1.2.364127676.1679297083; LPVID=ViYzQ1MWU1OTBmNGRiYzM5; LPSID-60365202=wXXRCvKkS6u4I5R4aca4Vg; TS0122f7ba=01761ac5de2d9bb9c8c5f5553fb12d389a2311d3b3c0ff6540bb8e2bfae870895fa6e621ae5469a9a29303df12f97d2c25f89b57eb24d134a36e4c6d751c8fd851c598dbb1bfaad8d162bf5790819b70ecf90baa5d9fcc3c622484eaff40e9abe15b7816cd; TS8adf36cf027=086434786fab2000e7752ee37a4fe0f7e36761bb76383c978e1ceebd2760d1c0c3348e0e903d686c08c15da4d7113000db3b1def04a971ddb53f3757316083d392884b553bc78119aa229c7e49509b2ebbc64f879f9b54c3be34deac7eea1e9e; _ga_DM7ESKSJRM=GS1.1.1679299183.2.1.1679299211.0.0.0; _ga=GA1.2.1783574726.1679297083; ADRUM=s=1679299254169&r=https%3A%2F%2Frevenue.delaware.gov%2Fbusiness-license-search%2F"
    req["Sec-Fetch-Dest"] = "document"
    req["Sec-Fetch-Mode"] = "navigate"
    req["Sec-Fetch-Site"] = "none"
    req["Sec-Fetch-User"] = "?1"
    req["Upgrade-Insecure-Requests"] = "1"
    req["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
    req["Sec-Ch-Ua"] = "\"Google Chrome\";v=\"111\", \"Not(A:Brand\";v=\"8\", \"Chromium\";v=\"111\""
    req["Sec-Ch-Ua-Mobile"] = "?0"
    req["Sec-Ch-Ua-Platform"] = "\"Linux\""
    
    req_options = {
      use_ssl: muri.scheme == "https",
    }
    responce = Net::HTTP.start(muri.hostname, muri.port, req_options) do |http|
        http.request(req)
    end
    puts responce.code
    paged=Nokogiri::HTML(responce.body)
    last_page=paged.css("div.pagination a")[-1].next_sibling.text.scan(/[1-9]/).join('').strip.to_i

(912..last_page).each{|pn|
    if pn==1
        base_url="https://revenue.delaware.gov/business-license-search/"
    else 
        base_url="https://revenue.delaware.gov/business-license-search/page/#{pn}/"
    end

    uri = URI.parse(base_url)
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
    request["Accept-Language"] = "en-US,en;q=0.9"
    request["Cache-Control"] = "max-age=0"
    request["Connection"] = "keep-alive"
    request["Cookie"] = "ROUTEID=.2; BIGipServer~DTI~proxy-geo-wordpress=4179173292.47873.0000; _gid=GA1.2.364127676.1679297083; LPVID=ViYzQ1MWU1OTBmNGRiYzM5; LPSID-60365202=wXXRCvKkS6u4I5R4aca4Vg; TS0122f7ba=01761ac5de2d9bb9c8c5f5553fb12d389a2311d3b3c0ff6540bb8e2bfae870895fa6e621ae5469a9a29303df12f97d2c25f89b57eb24d134a36e4c6d751c8fd851c598dbb1bfaad8d162bf5790819b70ecf90baa5d9fcc3c622484eaff40e9abe15b7816cd; TS8adf36cf027=086434786fab2000e7752ee37a4fe0f7e36761bb76383c978e1ceebd2760d1c0c3348e0e903d686c08c15da4d7113000db3b1def04a971ddb53f3757316083d392884b553bc78119aa229c7e49509b2ebbc64f879f9b54c3be34deac7eea1e9e; _ga_DM7ESKSJRM=GS1.1.1679299183.2.1.1679299211.0.0.0; _ga=GA1.2.1783574726.1679297083; ADRUM=s=1679299254169&r=https%3A%2F%2Frevenue.delaware.gov%2Fbusiness-license-search%2F"
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
    main_doc=Nokogiri::HTML(response.body)
    main_doc.css("div.topicBlock").map{|record|
        data_dic={}
        busines_name=record.css("h3").text.strip()
        data_dic["busines_name"]=busines_name
        details=record.css("div.detail p").each{|p|
            k,v=p.text.split(":")
            k.strip!
            v.strip!
            if k=="Valid From" || k=="Valid To"
                #YYYY-MM-DD
                # MM-DD-YYYY
                 #12-31-2023
                v_arr=v.split("-")
                v="#{v_arr[2]}-#{v_arr[0]}-#{v_arr[1]}"
            end
            data_dic[k]=v
        }
        data_dic["datasource_url"]=base_url
        mappings = {"busines_name"=>"business_name","License Number"=>"license_nr","Business Activity"=>"business_activity","Valid From"=>"valid_from","Valid To"=>"valid_to","Location"=>"location","datasource_url"=>"datasource_url"}
        full_data=data_dic.transform_keys(&mappings.method(:[]))
        Details.add_new(full_data)
        puts " Data inserted for Business #{busines_name} & Page: [#{pn}] Sucessfully "
    }
    
    puts "----------------------------------------------------------------"
    puts "                      Done Page #{pn}"
    puts "----------------------------------------------------------------"

    
}


