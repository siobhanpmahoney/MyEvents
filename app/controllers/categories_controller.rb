class CategoriesController < ApplicationController

  def music_events
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


end
