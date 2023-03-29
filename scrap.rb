require "nokogiri"
require "httparty"
require "byebug"
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'developer',
  password: 'Pakistan#123',
  database: 'cmhos'
)

class Details < ActiveRecord::Base
  self.table_name="details"
  def self.add_new(data_dict)
   Details.create(data_dict)
  end
 end

def name_splitter(name)
  name_array=name.split(" ")
end
def desc_split(desc)
  new_Arr=desc.strip.split(" -")
  return new_Arr
end

(1..295).each{|pn|
  url="https://www.cmohs.org/recipients/page/#{pn}"
  responce=HTTParty.get(url)
  doc=Nokogiri::HTML(responce.body)
  
  
  data=doc.css("#recipients_grid a").each{|sol|
    foji=sol.css("h2").text
    soldier=sol.css("h2").text.gsub(/['"]/, '')
    war=sol.css("h3").text.gsub(/[']/, '')
    desc=sol.css("span").text
    arr_desc=desc_split(desc)
    # puts arr_desc.length
    if arr_desc.count==2
      year=arr_desc[0].to_i
      place=arr_desc[1].gsub(/[']/,'')
    elsif  arr_desc.count==1
      year=arr_desc[0].to_i
      place=""
    elsif arr_desc.count==0
      year=0
      place=""
    end
    raw_data={}
    names=name_splitter(soldier)
    first_name=names[0]
    middle_name=names[1]
    if names.count==4
      last_name="#{names[2]} #{names[3]}"
    elsif names.count==5
      last_name="#{names[2]} #{names[3]} #{names[4]}"
    else
      last_name=names[2] || ""
    end
    details_url_name=foji.strip().downcase.gsub(/\. |\s+/, '-').gsub(/[".,]/ , '').gsub(/[()]/, '').gsub(/[']/, '')
    details_url="https://www.cmohs.org/recipients/#{details_url_name}"
    raw_data={
      "first_name"=>first_name,
      "middle_name"=>middle_name,
      "last_name"=>last_name,
      "war"=>war,
      "war_year"=>year,
      "place"=>place
    }

    details_responce=HTTParty.get(details_url)    
    doc_details=Nokogiri::HTML(details_responce.body)
    citation_data=doc_details.css("div.recipient-layout__title")[1]

    if citation_data.next_element
      citation=citation_data.next_element.text.strip
    elsif citation_data.next_sibling
      citation=citation_data.next_sibling.text.strip
    end


    doc_details.css("ul.list--effra")[0].css("li").map{|li|
      arr=li.css("strong").text.split(":")
      raw_data[arr[0].strip()]=arr[1].strip().gsub(/['"]/, '').split(",").map(&:strip).join(",")
    }
    raw_data["Citation"]=citation
    mappings = {"first_name"=>"first_name","middle_name"=>"middle_name","last_name"=>"last_name","war"=>"war","war_year"=>"war_year","place"=>"place",'Also Known As'=>'knwn_as','Rank' => 'rank_', 'Conflict/Era' => 'conf_era', 'Unit/Command' => 'unit_cmd', 'Military Service Branch' => 'mil_ser_br', 'Medal of Honor Action Date' => 'med_hr_d', 'Medal of Honor Action Place' => 'med_h_p', 'Citation' => 'citation' }
    full_data=raw_data.transform_keys(&mappings.method(:[]))
    
   


   Details.add_new(full_data)


    puts "record inserted page = #{pn} & soldier= #{names}"
  }
  puts "\n---------------------------------"
  puts "       Done Page #{pn}           "
  puts "---------------------------------"
  
}
puts "%%%%%%%%%%%%    All data inserted    %%%%%%%%%%%%"










