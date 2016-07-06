#!/usr/local/bin/ruby

=begin
wordmith.rb
=end

require 'rubygems'
require 'open-uri'
require 'nokogiri' 
require 'optparse'
require 'ostruct'

# This method changes text color to a supplied integer value which correlates to Ruby's color representation
def colorize(text, color_code)
	"\e[#{color_code}m#{text}\e[0m"
end

# This method changes text color to gray
def gray(text)
	colorize(text, 90)
end

# This method changes text color to red
def red(text)
  colorize(text, 31)
end

# This method changes text color to blue
def blue(text)
	colorize(text, 34)
end

def title()
  puts gray("wordsmith v1.0")
  puts gray("Written by: Sanjiv \"Trashcan Head\" Kawa & Tom \"Pain Train\" Porter")
  puts gray("Twitter: @skawasec & @porterhau5")
  puts ""
end

# This method asks a user to set a state. The idea is that state is then used throughout the HTML scraping process
def states(state)
  
  input = state 
  
  case input.upcase 
  when "ALL"
    puts "You chose all states."
    allStates()
  when "AL", "ALABAMA"
    puts "State set to: Alabama"
    @state = "Alabama"
  when "AK", "ALASKA"
    puts "State set to: Alaska"
    @state = "Alaska"
  when "AZ", "ARIZONA"
    puts "State set to: Arizona"
    @state = "Arizona"
  when "AR", "ARKANSAS"
    puts "State set to: Arkansas"
    @state = "Arkansas"
  when "CA", "CALIFORNIA"
    puts "State set to: California"
    @state = "California"
  when "CO", "COLORADO"
    puts "State set to: Colorado"
    @state = "Colorado"
  when "CT", "CONNECTICUT"
    puts "State set to: Connecticut"
    @state = "Connecticut"
  when "DE", "DELAWARE"
    puts "State set to: Delaware"
    @state = "Delaware"
  when "DC", "DISTRICT OF COLUMBIA"
    puts "State set to: District of Columbia"
    @state = "District of Columbia"
  when "FL", "FLORIDA"
    puts "State set to: Florida"
    @state = "Florida"
  when "GA", "GEORGIA"
    puts "State set to: Georgia"
    @state = "Georgia"
  when "HI", "HAWAII"
    puts "State set to: Hawaii"
    @state = "Hawaii"
  when "ID", "IDAHO"
    puts "State set to: Idaho"
    @state = "Idaho"
  when "IL", "ILLINOIS"
    puts "State set to: Illinois"
    @state = "Illinois"
  when "IN", "INDIANA"
    puts "State set to: Indiana"
    @state = "Indiana"
  when "IA", "IOWA"
    puts "State set to: Iowa"
    @state = "Iowa"
  when "KS", "KANSAS"
    puts "State set to: Kansas"
    @state = "Kansas"
  when "KY", "KENTUCKY"
    puts "State set to: Kentucky"
    @state = "Kentucky"
  when "LA", "LOUISIANA"
    puts "State set to: Louisiana"
    @state = "Louisiana"
  when "ME", "MAINE"
    puts "State set to: Maine"
    @state = "Maine"
  when "MD", "MARYLAND"
    puts "State set to: Maryland"
    @state = "Maryland"
  when "MA", "MASSACHUSETTS"
    puts "State set to: Massachusetts"
    @state = "Massachusetts"
  when "MI", "MICHIGAN"
    puts "State set to: Michigan"
    @state = "Michigan"
  when "MN", "MINNESOTA"
    puts "State set to: Minnesota"
    @state = "Minnesota"
  when "MS", "MISSISSIPPI"
    puts "State set to: Mississippi"
    @state = "Mississippi"
  when "MO", "MISSOURI"
    puts "State set to: Missouri"
    @state = "Missouri"
  when "MT", "MONTANA"
    puts "State set to: Montana"
    @state = "Montana"
  when "NE", "NEBRASKA"
    puts "State set to: Nebraska"
    @state = "Nebraska"
  when "NV", "NEVADA"
    puts "State set to: Nevada"
    @state = "Nevada"
  when "NH", "NEW HAMPSHIRE"
    puts "State set to: New Hampshire"
    @state = "New Hampshire"
  when "NJ", "NEW JERSEY"
    puts "State set to: New Jersey"
    @state = "New Jersey"
  when "NM", "NEW MEXICO"
    puts "State set to: New Mexico"
    @state = "New Mexico"
  when "NY", "NEW YORK"
    puts "State set to: New York"
    @state = "New York"
  when "NC", "NORTH CAROLINA"
    puts "State set to: North Carolina"
    @state = "North Carolina"
  when "ND", "NORTH DAKOTA"
    puts "State set to: North Dakota"
    @state = "North Dakota"
  when "OH", "OHIO"
    puts "State set to: Ohio"
    @state = "Ohio"
  when "OK", "OKLAHOMA"
    puts "State set to: Oklahoma"
    @state = "Oklahoma"
  when "OR", "OREGON"
    puts "State set to: Oregon"
    @state = "Oregon"
  when "PA", "PENNSYLVANIA"
    puts "State set to: Pennsylvania"
    @state = "Pennsylvania"
  when "RI", "RHODE ISLAND"
    puts "State set to: Rhode Island"
    @state = "Rhode Island"
  when "SC", "SOUTH CAROLINA"
    puts "State set to: South Carolina"
    @state = "South Carolina"
  when "SD", "SOUTH DAKOTA"
    puts "State set to: South Dakota"
    @state = "South Dakota"
  when "TN", "TENNESSEE"
    puts "State set to: Tennessee"
    @state = "Tennessee"
  when "TX", "TEXAS"
    puts "State set to: Texas"
    @state = "Texas"
  when "UT", "UTAH"
    puts "State set to: Utah"
    @state = "Utah"
  when "VT", "VERMONT"
    puts "State set to: Vermont"
    @state = "Vermont"
  when "VA", "VIRGINIA"
    puts "State set to: Virginia"
    @state = "Virginia"
  when "WA", "WASHINGTON"
    puts "State set to: Washington"
    @state = "Washington"
  when "WV", "WEST VIRGINIA"
    puts "State set to: West Virginia"
    @state = "West Virginia"
  when "WI", "WISCONSIN"
    puts "State set to: Wisconsin"
    @state = "Wisconsin"
  when "WY", "WYOMING"
    puts "State set to: Wyoming"
    @state = "Wyoming"
  else
    puts ""
  	puts red("#{input} is an invalid state please type the state name or abbrevation. For example \"California\" or \"CA\".")
    abort
  end
end

# this method will check if a url is valid
def urlChecker(url)
  begin
    page = Nokogiri::HTML(open(url))
  rescue OpenURI::HTTPError => e
    puts "Can't access: #{url}"
    puts red("Error Message: #{e.message}") 
    puts "Exiting this method!"
  end
end

# this method will replace any spaces in a state with %20 so that the URL is properly formatted
def urlFormatter(stateSet)
  if stateSet.include? "\s"
    @url=stateSet.gsub!(/\s/,'%20') # replace any spaces in the state with the URL equivilent
  else
    @url = stateSet # just return the original state
  end 
end

# this method will pull all data required for this program and store to HTML. 
def pull()
  
  files = ["data/sports.html", "data/Connecticut-landmarks.html", "data/Connecticut-cities.html", "data/babynames-17.html", "data/Connecticut-zip.html"] # random selection of files
      
  if File.exist?(files[0]) == true
    puts "File for sports teams in the USA exists already." 
  else
    pullSports()
  end
    
  if File.exist?(files[1]) == true && File.exist?(files[2]) == true
    puts "Files for cities, towns and landmarks exists already."
  else
    pullCitiesTownsLandcapes()
  end
      
  if File.exist?(files[3]) == true
    puts "Files for common first name, last names and baby names exists already."
  else
    pullNames()
  end
  
  if File.exist?(files[4]) == true
    puts "Files for zip codes exists already."
  else
    pullZip()
  end
  puts ""
  puts blue("To ignore and download again, type fpull")
end

# this method will check to see if the file exists before it is processed. 
def fileCheck(file)
  files = file
    
  if File.exist?(files) == false
    puts " "
    puts "Whoops!"
    puts "The file named #{files} does not exist amd wordsmith needs that to process this request."
    puts "Please update the program using the force update function or run setup.sh to unpack data.tar.gz" 
    puts red("EXITING!")
    abort
  end
end

# this method will forcefully pull all data required for and store to HTML. 
def fpull()
  %x[mkdir data/]
  puts blue("Downloading 100MB of data. Please be patient.")
  puts ""
  pullSports()
  pullCitiesTownsLandcapesDC() 
  pullCitiesTownsLandcapes()
  pullRoads()
  pullNames()
  pullZip()
  pullAreaCodes()
  pullCewl()
end

# this method will pull all data required for sports teams per state and store to HTML. 
def pullSports()
  url  = "https://en.wikipedia.org/wiki/Major_professional_sports_teams_of_the_United_States_and_Canada"
  page = urlChecker(url)
  sportsTeams = "data/sports.html" 
  puts "Grabbing USA sports teams for all states and storing to disk"
  output = File.open(sportsTeams,"w") 
  output.write page # store the url above into a file named data/sports.html
  output.close
  
  puts "Success, files stored in #{Dir.pwd}/data/"
  puts ""
end

def pullCitiesTownsLandcapesDC() 
  state = "District%20of%20Columbia"
  
  landmarkUrl = "https://en.wikipedia.org/wiki/List_of_National_Historic_Landmarks_in_Washington,_D.C."
  landmark = urlChecker(landmarkUrl)
  
  output = File.open("data/#{state}-landmarks.html","w")
  output.write landmark # cycle through array, for each state, grab the wikipedia entry in the cities url set above and store the HTML file to disk
  output.close 
end

# this method will pull all data required for cities, towns and landscapes per state and store to HTML. 
def pullCitiesTownsLandcapes()
  statesArr = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
  statesArrLength = statesArr.length.to_i
  count = 0
  
  puts "Grabbing Cities, Townships and Landmarks for all States and storing to disk"
  
  until count == statesArrLength
    stateSet = statesArr[count]
    state = urlFormatter(stateSet) #replace any spaces in a state with %20 so that the URL is properly formatted
    
    if stateSet == "Georgia" # GA needs special URL formatting to distinguish the state from the country
      citiesUrl = "https://en.wikipedia.org/wiki/List_of_municipalities_in_Georgia_(U.S._state)"
    else
      citiesUrl  = "https://en.wikipedia.org/wiki/List_of_cities_in_#{state}" # URL set to state
    end
        
    cities = urlChecker(citiesUrl)
    
    landmarkUrl = "https://en.wikipedia.org/wiki/List_of_National_Historic_Landmarks_in_#{state}" # URL set to state
    
    landmark = urlChecker(landmarkUrl)
    
    output = File.open("data/#{state}-cities.html","w")
    output.write cities # cycle through array, for each state, grab the wikipedia entry in the cities url set above and store the HTML file to disk
    output.close  
    
    output = File.open("data/#{state}-landmarks.html","w")
    output.write landmark # cycle through array, for each state, grab the wikipedia entry in the landmark url set above and store the HTML file to disk
    output.close 
    
    count = count + 1
    print "%.2f" % (count/statesArrLength.to_f * 100)
    print "% " 
  end
  puts ""
  puts "Success, files stored in #{Dir.pwd}/data/"
  puts ""
end

# this method will pull all data required for popular names in the US and store to HTML. 
def pullNames()
  puts "Grabbing most common lastnames, first names, and baby names and and storing to disk"
  
  namesUrl = ["http://names.mongabay.com/most_common_surnames.htm",
    "http://names.mongabay.com/most_common_surnames1.htm",
    "http://names.mongabay.com/most_common_surnames2.htm",
    "http://names.mongabay.com/most_common_surnames5.htm",
    "http://names.mongabay.com/most_common_surnames8.htm",
    "http://names.mongabay.com/male_names.htm",
    "http://names.mongabay.com/male_names3.htm",
    "http://names.mongabay.com/male_names6.htm",
    "http://names.mongabay.com/male_names9.htm",
    "http://names.mongabay.com/female_names.htm",
    "http://names.mongabay.com/female_names1.htm"]
  
    babyNamesUrl = ["http://names.mongabay.com//baby_names/boys-2014.html",
    "http://names.mongabay.com//baby_names/boys500.html",
    "http://names.mongabay.com//baby_names/boys750.html",
    "http://names.mongabay.com//baby_names/boys1000.html",
    "http://names.mongabay.com//baby_names/girls-2014.html",
    "http://names.mongabay.com//baby_names/girls500.html",
    "http://names.mongabay.com//baby_names/girls750.html",
    "http://names.mongabay.com//baby_names/girls1000.html"]
  
   count = 0
   final = 19.0
  
   namesUrl.each{ |url| 
     page = urlChecker(url)
     output = File.open("data/names-#{count}.html","w")
     output.write page # cycle through array, for each namesUrl, grab and store the HTML file to disk
     output.close 
     count = count + 1
     print "%.2f" % (count/final * 100)
     print "% "
   }
   
   babyNamesUrl.each{ |url| 
     page = urlChecker(url)
     output = File.open("data/babynames-#{count}.html","w")
     output.write page # cycle through array, for each namesUrl, grab and store the HTML file to disk
     output.close 
     count = count + 1
     print "%.2f" % (count/final * 100)
     print "% "
   }
   puts ""
   puts "Success, files stored in #{Dir.pwd}/data/"
   puts ""
end

# this method will pull all data required for zip codes per state and store to HTML. 
def pullZip()
  statesArr = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
  # statesArr contains DC
  statesArrLength = statesArr.length.to_i
  count = 0
  
  puts "Grabbing zip codes for all States and storing to disk"
  
  until count == statesArrLength
    stateSet = statesArr[count]
    
    state = urlFormatter(stateSet) #replace any spaces in a state with %20 so that the URL is properly formatted
    url = "http://www.zipcodestogo.com/#{state}/" # set the state in the specified URL
    
    zip = urlChecker(url)
    
    output = File.open("data/#{state}-zip.html","w")
    output.write zip # cycle through array, for each state and store the HTML file containing zip codes to disk
    output.close  
    
    count = count + 1
    print "%.2f" % (count/statesArrLength.to_f * 100)
    print "% " 
  end
  puts ""
  puts "Success, files stored in #{Dir.pwd}/data/"
  puts ""
end

# this method will pull all area codes for each state and store to disk
def pullAreaCodes()
  puts "Grabbing area codes for all States and storing to disk"
  File.open("data/usa-area-codes.csv", "wb") do |saved_file|
    open("https://docs.google.com/uc?export=download&id=0B9YAGU9c9zmKV1ZNZFEza2tiSzQ", "rb") do |read_file|
      saved_file.write(read_file.read)
    end
  end
    
  puts "Success, file stored in #{Dir.pwd}/data/"
  puts ""
end

# this method will pull all roads for each state and store to disk
def pullRoads()
  puts "Grabbing streets and roads for all States and storing to disk"
  File.open("roads.tar.gz", "wb") do |saved_file|
    open("https://docs.google.com/uc?export=download&id=0B9YAGU9c9zmKbF9LSTZCY1UzNXc", "rb") do |read_file|
      saved_file.write(read_file.read)
    end
  end
  
  %x[tar -xf roads.tar.gz]
  %x[rm roads.tar.gz]  
  
  puts "Success, file stored in #{Dir.pwd}/roads/"
  puts ""
end

# this method will get all of the sports teams for a given state
def sportsTeams(stateSet)
  url  = "data/sports.html"
  fileCheck(url)
  page = urlChecker(url)
  tdLength = page.css('td').length.to_i # get a count of the table data attributs on the page
  
  team = 0 # 0 represents the first table row which is the sports team name 
  state = 2 # 2 represents the third table row which is the state of the corresponding sports team 
  teamsHash = Hash.new()
  
  until team == tdLength
    key = page.css('td')[team].text # key is the sports team name as this is unique
    value = page.css('td')[state].text # value is the state of the sports team
    teamsHash[key.to_s] = value.to_s 
    team = team + 7 # plus 7 to go back to the first element in the table, which is the name of the sports team
    state = state + 7 # plus 7 to go back to the thrid element in the table, which is the state of the corresponding sports team 
  end
  
  teamsArr = []
  
  teamsHash.select{ |team, state|
    if state == stateSet 
      teamsArr.push team.to_s # add all of the sports teams for a specific state into an array
    end}
    
   if teamsArr.empty?
     puts "Sorry, there are no sports teams in #{stateSet}"
   else
     @teamsArr = postProcessor(teamsArr)
     if $quiet != true
       puts @teamsArr
       puts ""
     end
     if stateSet.include?("%20")
       stateSet = stateSet.gsub!(/%20/,' ')
       puts "Total words for sports teams in #{stateSet} is: #{@teamsArr.length}"
     else
       puts "Total words for sports teams in #{stateSet} is: #{@teamsArr.length}"
     end
   end
end

# this method will get all of the cities and towns for a given state.
def cities(stateSet)
  state = urlFormatter(stateSet) #replace any spaces in a state with %20 so that the URL is properly formatted

  if stateSet == "District%20of%20Columbia"
     cities = ["Washington"]
     @cities = postProcessor(cities)
     if $quiet != true
       puts @cities
       puts ""
     end
     puts "Total words for cities and towns in District of Columbia is: #{@cities.length}"
  else
    url = "data/#{state}-cities.html"
    fileCheck(url)
    page = urlChecker(url)
    
    row = page.css('table.wikitable tr') # look for all table rows in the supplied URL as entries for cities and towns are likely to be in a table
    cities = row.css('a').map {|city| city.text} # filter down to all table rows containing a hyperlink, as cities and towns are likley to be wrapped in "a href"
    cities = cities.sort.uniq.delete_if {|city| city.include?("]") } # sort and delete duplicates, then delete any line that contains brackets 
    cities = cities.delete_if {|city| city.include?("http") } # delete any line that contains that has http  
    cities = cities.delete_if {|city| city.include?(";") } # delete any line that contains that has a ; - typically coordinates
    cities = cities.delete_if {|city| city.match(/\d\d/) } # delete any line that has at least 2 consequtive numbers (year or neighbourhoods in city)
    cities = cities.delete_if {|city| city[0].match(/^[a-z]/)} # delete any line where the first character of a string starts with a lower case letter
    cities = cities.each {|city| city.gsub!(/\([^()]*\)/,'')} # delete anything within parenthesis and the parenthesis themselves
    cities = cities.each {|city| city.gsub!(/†/,'')} # replace the † character - typically used for references on wikipedia
    cities = cities.each {|city| city.gsub!(/\s+$/,'')} # remove all trailing spaces from a string
    cities = cities.sort.uniq # perform another sort and uniq
    @cities = postProcessor(cities)
    if $quiet != true
      puts @cities
      puts ""
    end
    if state.include?("%20")
      state = state.gsub!(/%20/,' ')
      puts "Total words for cities and towns in #{state} is: #{@cities.length}"
    else
      puts "Total words for cities and towns in #{state} is: #{@cities.length}"
    end
  end
end

# this method will get all of the landmarks for a state
def landmarks(stateSet)
  
  state = urlFormatter(stateSet) #replace any spaces in a state with %20 so that the URL is properly formatted
  if stateSet == "District%20of%20Columbia" # DC needs special URL formatting
    url = "data/District%20of%20Columbia-landmarks.html"
  else
     url = "data/#{state}-landmarks.html"
  end
  fileCheck(url)
  page = urlChecker(url)
  row = page.css('table.wikitable tr') # look for all table rows in the supplied URL as entries for landmarks are likely to be in a table
  landmark = row.xpath('./td[1]').map {|lm| lm.text} # grab the first td from each tr. this is likely going to contain a landmark
  landmark = landmark.each {|lm| lm.gsub!(/\([^()]*\)/,'')} # delete anything within parenthesis and the parenthesis themselves
  landmark = landmark.each {|lm| lm.gsub!(/\[[^\[\]]*\]/,'')} # delete anything within brackets and the brackets themselves
  landmark = landmark.each {|lm| lm.gsub!(/\s+$/,'')} # remove all trailing spaces from a string
  landmark = landmark.sort.uniq
  badChars = ["1","2","1*","2*","3#","3","4","5","Legend","Site\stype","",nil]
  temp = landmark - badChars    
  @landmark = postProcessor(temp)
  if $quiet != true
    puts @landmark
    puts ""
  end
  if state.include?("%20")
    state = state.gsub!(/%20/,' ')
    puts "Total words for landmarks in #{state} is: #{@landmark.length}"
  else
    puts "Total words for landmarks in #{state} is: #{@landmark.length}"
  end    
end

# this method will get all of the zip codes for a state
def zip(stateSet)
  state = urlFormatter(stateSet)
  url = "data/#{state}-zip.html"
  fileCheck(url)
  page = urlChecker(url)
  div = page.css('div#leftCol') # focus on the left div column
  table = div.css('table.inner_table') # focus on the inner table
  row = table.css('tr') # grab all the table rows from the inner table
  zip = row.css('td[1]').map {|n| n.text} # grab the first table data element from each table row
  zip.delete_at(0) # delete text that contains "zip codes for the state of x"
  zip.delete_at(0) # delete text that contains "zip codes"
  @zip = zip  
  if $quiet != true
    puts @zip
    puts ""
  end
  if stateSet.include?("%20")
    stateSet = stateSet.gsub!(/%20/,' ')
    puts "Total zip codes in #{stateSet} is: #{@zip.length}"
  else
    puts "Total zip codes in #{stateSet} is: #{@zip.length}"
  end
end

# this method will get all of the area codes for a state
def areaCode(stateSet)
  stateSet.gsub!('%20',' ')
  areaCodesFile = "data/usa-area-codes.csv"
  fileCheck(areaCodesFile)
  stateLine = File.open(areaCodesFile).grep(/^#{stateSet}/).join(', ').split(',') # grep the state name in the area codes csv file and place into an array called line
  stateLine.delete_at(0) # The first element contains the state name. Delete this.
  @areaCode = stateLine
  if $quiet != true
    puts @areaCode
    puts ""
  end
  puts "Total area codes in #{stateSet} is: #{@areaCode.length}"
end

# this method will get all of the road names for a state
def roads(stateSet)
  state = urlFormatter(stateSet) #replace any spaces in a state with %20 so that the URL is properly formatted
  filename = "roads/#{state}-roads.txt"
  fileCheck(filename)
  file = File.open(filename, "rb")
  contents = file.read
  file.close
  roads = contents.split("\n")

  @roads = postProcessor(roads)
 
  if $quiet != true
    puts @roads
    puts ""
  end
  if stateSet.include?("%20")
    stateSet = stateSet.gsub!(/%20/,' ')
    puts "Total words for roads and streets in #{stateSet} is: #{@roads.length}"
  else
    puts "Total words for roads and streets in #{stateSet} is: #{@roads.length}"
  end
end

# this method will pull a custom version of CeWL down
def pullCewl()
  puts "Grabbing CeWL and storing to disk"
  File.open("cewl.tar.gz", "wb") do |saved_file|
    open("https://docs.google.com/uc?export=download&id=0B9YAGU9c9zmKVVg2ZEQyWUw3aWs", "rb") do |read_file|
      saved_file.write(read_file.read)
    end
  end
  
  %x[tar -xf cewl.tar.gz]
  %x[rm cewl.tar.gz]  
  
  puts "Success, file stored in #{Dir.pwd}/cewl/"
  puts ""
end

=begin
this method will get 1) 12k most common surnames in USA. 2) 1.2k common male names in USA. 
3) 2k common female names in USA. 4) 1k boys names from 2014 5) 1k girls names from 2014
=end 
def names()

  namesUrl = ["data/names-0.html",
    "data/names-1.html",
    "data/names-2.html",
    "data/names-3.html",
    "data/names-4.html",
    "data/names-5.html",
    "data/names-6.html",
    "data/names-7.html",
    "data/names-8.html",
    "data/names-9.html",
    "data/names-10.html"]
  
  names = []
  
  count = 0
  final = 19.0
  
  namesUrl.each{ |url| # iterate through each last name URL
    fileCheck(url)
    page = urlChecker(url)
    row = page.css('tr') # look for all table rows in the supplied URL
    currentName = row.xpath('./td[1]').map {|n| n.text} # grab the first td
    names = names + currentName # add into lastname array
    count = count + 1
  }
  
  babyNamesUrl = ["data/babynames-11.html",
    "data/babynames-12.html",
    "data/babynames-13.html",
    "data/babynames-14.html",
    "data/babynames-15.html",
    "data/babynames-16.html",
    "data/babynames-17.html",
    "data/babynames-18.html"]

  babyNames = []
    
  babyNamesUrl.each{ |url| # iterate through each last name URL
    fileCheck(url)
    page = urlChecker(url)
    row = page.css('tr') # look for all table rows in the supplied URL
    currentName = row.xpath('./td[2]').map {|n| n.text} # grab the first td
    babyNames = babyNames + currentName # add into lastname array
    count = count + 1
  }
  
  names = names.sort.uniq.map(&:downcase).map(&:capitalize)
  babyNames = babyNames.sort.uniq.map(&:downcase).map(&:capitalize)
  
  allNames = names + babyNames
  
  @allNames = allNames.sort.uniq
  if $quiet != true
    puts @allNames
    puts ""
  end
  puts "Total common names in the USA is: #{@allNames.length}"
end

# run CeWL against the specified URL
def scrapeSingle(url)
  puts "Running CeWL against: #{url}"
  cewl = %x[ruby cewl/cewl.rb #{url}]
  # convert to array, remove first two entries (CeWL banner and blank line)
  # sort and uniq
  result = cewl.split("\n").drop(2).sort.uniq
  
  @cewl = postProcessor(result)
  puts ""
  if @cewl.nil?
    puts "#{url} seems to be incorrect. Please check it in a web browser and try again."
    puts "Total unique words that CeWL grabbed from #{url} is: 0"
  else
    if $quiet != true
      puts @cewl
      puts ""
    end
    puts "Total unique words that CeWL grabbed from #{url} is: #{@cewl.length}"
  end
end

# run CeWL against a wordlist containing multiple URLs
def scrapeMultiple(infile)
  input = infile
  fileCheck(input)
  allCewls = []
  
  count = 1
  lineCount = File.foreach(input).count

  File.foreach(input) do |url|
    puts "Running CeWL against: #{url.chomp} (#{count}/#{lineCount})"
    cewl = %x[ruby cewl/cewl.rb #{url}]
    if cewl.include? "Unable to connect to the site"
      puts "-- Unable to connect to the site"
    else
      # remove first two entries (CeWL banner and blank line), append to array
      allCewls = allCewls + (cewl.split("\n").drop(2))
      puts ""
      puts "Total words that CeWL grabbed from #{url.chomp} is: #{cewl.length}"
      puts ""
      count = count + 1
    end
  end

  # sort and uniq
  result = allCewls.sort.uniq
  @allCewls = postProcessor(result)
  puts "Total unique words that CeWL grabbed from all URL's is: #{@allCewls.length}"
end

# run all functions against the specified state
def all(stateSet)
  sportsTeams(stateSet)
  cities(stateSet)
  landmarks(stateSet)
  zip(stateSet)
  areaCode(stateSet)
  roads(stateSet)
  names()
end

# usage examples
def examples()
  puts "Grab all of the cities and towns for California"
  puts "    ruby wordsmith.rb -s CA -c"
  puts "\nGrab everything for California, write to file named california.txt"
  puts "    ruby wordsmith.rb -s CA -a -o california.txt"
  puts "\nGrab everything for California and run CeWL against https://www.popped.io"
  puts "    ruby wordsmith.rb -s CA -a -d https://www.popped.io"
  puts "\nCreate a mega wordlist containing all states with all options, quiet output"
  puts "    ruby wordsmith.rb -s all -q -o wordsmith-all.txt"
  puts "\nGrab the most common male, female, baby and last names in the USA"
  puts "    ruby wordsmith.rb -n"
end

=begin
this will take the contents of an array that is given to it and perform various manipulation functions.
this includes, keeping the original state of the array
taking each line and splitting it on a space in to seperate words
removing all special characters from a word
=end
def postProcessor(array)
  
  count = 0  
  length = array.length
  
  wordsSplit = []
  
  until count == length
    words = array[count].split()
    wlength = words.length
    wcount = 0
    until wcount == wlength
      wordsSplit.push words[wcount].split().to_s
      wcount = wcount + 1
    end  
    count = count + 1
  end
  
  specialCharRemoved = []
  wordsSplit.each {|word| specialCharRemoved.push word.to_s.gsub!(/[^0-9A-Za-z]/, '')}
  
  finalArr = [] 
  
  array.each {|word| finalArr.push word.to_s} 
  wordsSplit.each {|word| finalArr.push word.to_s} 
  specialCharRemoved.each {|word| finalArr.push word.to_s} 
  
  @finalArr = finalArr.sort!.uniq!  
end

# all states
def allStates()
  statesArr = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
  allArr = Array.new
  
  count = 0
  
  statesArr.each {|state|
    stateSet = state.to_s

    puts "--#{stateSet}--"
    
    sportsTeams(stateSet)
    if @teamsArr.nil? == false
      @teamsArr.each {|line| allArr.push line.to_s}
    end

    cities(stateSet)
    if @cities.nil? == false
      @cities.each {|line| allArr.push line.to_s}
    end
    
    landmarks(stateSet)
    if @landmark.nil? == false
      @landmark.each {|line| allArr.push line.to_s}
    end
    
    areaCode(stateSet)
    if @areaCode.nil? == false
      @areaCode.each {|line| allArr.push line.to_s}
    end
    
    zip(stateSet)
    if @zip.nil? == false
      @zip.each {|line| allArr.push line}
    end

    roads(stateSet)
    if @roads.nil? == false
      @roads.each {|line| allArr.push line.to_s}
    end
 
    count = count + 1
  }
  
  names()
  if @allNames.nil? == false
    @allNames.each {|line| allArr.push line.to_s}
  end
  
  allArr.sort!.uniq!
  @allArr = allArr.reject {|el| el.empty?}
  @allArrCount = count
end

# output file
def output(file)
  
  outputArr = Array.new
    
  if @teamsArr.nil? == false
    @teamsArr.each {|line| outputArr.push line.to_s}
  end

  if @cities.nil? == false
    @cities.each {|line| outputArr.push line.to_s}
  end

  if @landmark.nil? == false
    @landmark.each {|line| outputArr.push line.to_s}
  end

  if @areaCode.nil? == false
    @areaCode.each {|line| outputArr.push line.to_s}
  end

  if @zip.nil? == false
    @zip.each {|line| outputArr.push line}
  end

  if @roads.nil? == false
    @roads.each {|line| outputArr.push line.to_s}
  end

  if @allNames.nil? == false
    @allNames.each {|line| outputArr.push line.to_s}
  end

  if @cewl.nil? == false
      @cewl.each {|line| outputArr.push line.to_s}
  end

  if @allCewls.nil? == false
    @allCewls.each {|line| outputArr.push line.to_s}
  end
  
  if @allNames.nil? == false
    @allNames.each {|line| outputArr.push line.to_s}
  end

  outputArr.sort!.uniq!
  outputArr = outputArr.reject {|el| el.empty?}
    
  if @allArrCount == 51
    File.open(file,"w" ) do |f|  
      @allArr.each {|line| f.puts(line)}     
    end 
  else
    File.open(file,"w" ) do |f|
      outputArr.each {|line| f.puts(line)}
    end
  end

  puts ""
  puts blue("Output written to: #{Dir.pwd}/#{file}")
end

# CLI Arguments
def cli()
  options = OpenStruct.new
  ARGV << '-h' if ARGV.empty?
  OptionParser.new do |opt|
    opt.banner = "Usage: ruby wordsmith.rb [options]"
    opt.on('Main Arguments:')
    opt.on('-s', '--state STATE', 'The US state set for the program') { |o| options.state = o }
    opt.on('State Options:')
    opt.on('-a', '--all', 'Grab everything for the specified state') { |o| options.all = o }
    opt.on('-c', '--cities', 'Grab all city names for the specified state') { |o| options.cities = o }
    opt.on('-l', '--landmarks', 'Grab all landmarks for the specified state') { |o| options.landmarks = o }    
    opt.on('-p', '--phone', 'Grab all area codes for the specified state') { |o| options.phone = o }
    opt.on('-r', '--roads', 'Grab all road names in the specified state') { |o| options.roads = o }
    opt.on('-t', '--teams', 'Grab all major sports teams in the specified state') { |o| options.sports = o }
    opt.on('-z', '--zip', 'Grab all zip codes for the specified state') { |o| options.zip = o }
    opt.on('Miscellaneous Options:')
    opt.on('-d', '--domain DOMAIN', 'Set a URL for a web application that you want CeWL to scrape') { |o| options.url = o }
    opt.on('-e', '--examples', 'Show some usage examples') { |o| options.examples = o }
    opt.on('-i', '--infile FILE', 'Supply a file containing multiple URLs for web applications that you want CeWL to scrape') { |o| options.multi = o }
    opt.on('-n', '--names', 'Grab the most common male, female, baby and last names in the USA') { |o| options.names = o }
    opt.on('-o', '--output FILE', 'The name of the output file') { |o| options.out = o }
    opt.on('-q', '--quiet', 'Don\'t show words generated, use with -o option') { |o| options.quiet = o }
    opt.on('Management:')
    opt.on('-u', '--update', 'Update the program') { |o| options.update = o }
    opt.on('-f', '--force', 'Forcefully update the program') { |o| options.fupdate = o }
  end.parse!

  stateSet = options.state
  all = options.all
  cities = options.cities
  examples = options.examples
  landmarks = options.landmarks
  multiUrl = options.multi
  names = options.names
  outputFile = options.out
  phone = options.phone
  $quiet = options.quiet
  roads = options.roads
  sports = options.sports
  url = options.url
  update = options.update
  updateForce = options.fupdate
  zip = options.zip
  
  # these options do need a state to be set in order to run
  if stateSet.nil? == false then state = states(options.state) end
  if stateSet.nil? == false && all == true then all(state) end
  if stateSet.nil? == false && cities == true then cities(state) end
  if stateSet.nil? == false && landmarks == true then landmarks(state) end  
  if stateSet.nil? == false && phone == true then areaCode(state) end  
  if stateSet.nil? == false && roads == true then roads(state) end    
  if stateSet.nil? == false && sports == true then sportsTeams(state) end   
  if stateSet.nil? == false && zip == true then zip(state) end
    
  # these options do not need a state to be set in order to run
  if examples == true then examples() end  
  if names == true then names() end  
  if update == true then pull() end    
  if updateForce == true then fpull() end 
  if url.nil? == false then scrapeSingle(url) end 
  if multiUrl.nil? == false then scrapeMultiple(multiUrl) end 
  if outputFile.nil? == false then output(outputFile) end
end

=begin 
Check to see if the correct directory structure exists
If the user double clicks on data.tar.gz then all foders will be listed within data/
Folders need to be listed independantly, like cewl/ data/ and roads/
=end
def firstRun()
  cewlCheck = "./cewl/cewl.rb"
  roadCheck = "./data/Arizona-cities.html"
  dataCheck = "./roads/Arizona-roads.txt"
    
  if File.exist?(cewlCheck) == false ||  File.exist?(roadCheck) == false || File.exist?(dataCheck) == false
    archiveCheck = "data.tar.gz"
    if File.exist?(archiveCheck) == false
      puts red("data.tar.gz not detected! Please run wordsmith with the force update option.")
      puts ""
    else
      puts blue("Hello new wordsmither! Just need to unpack some files.")
      %x[rm -rf data/]
      %x[rm -rf roads/]
      %x[rm -rf cewl/]
      %x[tar -xf data.tar.gz]
      puts ""
      puts blue("Unpack completed!")
      puts ""
    end
  end
end

title()
firstRun()
cli()