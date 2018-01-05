class CategoriesController < ApplicationController

  def music_events
    byebug
    @all_music = Event.all.select {|e| e.categories[0].classification_name == "Music"}

  end

  def all_sports_events
    @all_sports = Event.all.select {|e| e.categories.classification_name == "Sports"}
  end

  def all_arts_events
    @all_arts = Event.all.select {|e| e.categories.classification_name == "Arts & Theatre"}
  end

  def all_misc_events
    @all_misc = Event.all.select {|e| e.categories.classification_name == "Miscellaneous"}
  end

   private
   # def classification_list
   #   @all_music.map {|c| c.categories[0].genre_name }.uniq
   # end
   #
   # cat_hash = [classification => [{genre: [subgenres]}]





#
#     @events.map do |e|
#
#       if c == e.categories[0].classification_name && !ch.include(c)
#         ch << {c => [e.categories[0].genre_name]}
#       end
#     end
#   end
#   ch
# end
#
#
#   ch
# end
#
# def
#
#
#   @all_music.each do |c|
#     if !ch.include?(c)
#       ch << c
#     end
#     ch
#   end
# end


   #
   # end


  #     a.categories[0].genre_
  #   end
  # end
  #
  # def mus_subgenres
  #   array = []
  #   mus_genres.each do |g|
  #     subg_array = @all_music.select {|s| s.categories[0].}
  #     array << g =>


end
