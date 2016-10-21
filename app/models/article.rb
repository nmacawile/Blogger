class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

	has_attached_file :image, styles: { attached: "720>x405", medium: "300x300>", thumb: "50x50#" }

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	
	#without the custom to_s method in models/tag.rb
	#def tag_list
	#  self.tags.collect do |tag|
	#    tag.name
  	#  end.join(", ")
	#end
	
	#with the custom to_s method
	def tag_list
	  tags.join(", ")
	end
	#

	def tag_list=(tags_string)
	  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
	  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
	  self.tags = new_or_found_tags
	end

	def increment_hits
	  self.increment!(:hits)
	end

end

