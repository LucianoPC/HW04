# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    mv = Movie.new()
    mv.title = movie[:title]
    mv.rating = movie[:rating]
    mv.release_date = movie[:release_date]
    mv.director = movie[:director]
    mv.save!
  end
end

Then /the director of "(.*?)" should be "(.*?)"/ do |title, director|
	assert Movie.find_by_title(title).director == director
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.index("#{e1}") < page.body.index("#{e2}") 
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(", ")

  ratings.each do |rating|
   if uncheck.blank?
      check("ratings[#{rating}]")
   else
      uncheck("ratings[#{rating}]")
   end
  end
end

Then /I should see all the movies/ do
  Movie.all.each do |movie|
    steps %Q{
      And I should see "#{movie.title}"
    }
  end
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

# Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
#   assert page.body.index("#{e1}") < page.body.index("#{e2}") 
# end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

# When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # ratings = rating_list.split(", ")

  # ratings.each do |rating|
  #  if uncheck.blank?
  #     check("ratings[#{rating}]")
  #  else
  #     uncheck("ratings[#{rating}]")
  #  end
  # end
# end

# Then /I should see all the movies/ do
#   Movie.all.each do |movie|
#     steps %Q{
#       And I should see "#{movie.title}"
#     }
#   end
# end