class TagsController < ApplicationController

  def self.create(tag)
    Tag.find_or_create_by(description: tag)
  end
end
