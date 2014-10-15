require "spec_helper"

describe MoviesController do

	describe "delete movie"

		before :each do
			@movie = Movie.create(title: "Star Wars VII", rating: "PG", description: "The Best", release_date: "15/08/2015", director: "J.J. Abrams")
		end

		it "view movie details" do
			get :destroy, id: @movie.id
		end

end
