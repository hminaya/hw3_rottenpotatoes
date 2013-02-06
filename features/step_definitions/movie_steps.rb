# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create movie
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "([^"]*)" before "([^"]*)"/ do |e1, e2|
  regexp = "(?m)" + e1 + ".*" + e2
  regexp = Regexp.new(regexp)

  if page.body.respond_to? :should
    page.body.should =~ regexp
  else
    assert regexp.match(page.body)
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |rating|
    if uncheck
      uncheck("ratings_"+rating)
    else
      check("ratings_"+rating)
    end
  end
end

Then /I should see all of the movies/ do
  #puts page.body
  @movies = Movie.find(:all).length
  @rows = (page.body.scan(/<tr>/).length - 1)
  @rows.should == @movies

end