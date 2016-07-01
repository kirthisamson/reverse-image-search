class Image
  include MongoMapper::Document

  key :name, String
  key :signature, String
  key :disc, String
  key :artist, String
  key :historical_context, String
  key :medium, String
  key :dimensions, String

def self.find_image_by_signature(signature)
	image = Image.find_by_signature(signature)
	if image
		return image
	else
		puts("No absolute match found, proceeding to sectional search \n This can be time consuming. Thank you for your patience")
		image = find_image_by_sectional_matching(signature)
	end
end

def self.find_image_by_sectional_matching(signature)
	puts("in sectional_matching")
	length_of_signature = signature.length
	puts "length_of_signature: #{length_of_signature}"

	images = Image.all
	max_match_image = nil
	max_match_count = 0
	images.each do |image|
		img_sign = image.signature
		img_sign_length = img_sign.length
		if length_of_signature == img_sign_length
			#removing word color
			signature_stripped = signature[5...length_of_signature]
			sign_stripped = img_sign[5...img_sign_length]
			signature_split = signature_stripped.scan(/.{3}/)
			sign_split = sign_stripped.scan(/.{3}/)

			match_count = 0
			signature_split.each_with_index do |ss , index|
				if ss == sign_split[index]
					match_count += 1
				end
			end

			if match_count > max_match_count
				max_match_count = match_count
				max_match_image = image
			end
		end
	end
	puts("max_match_count #{max_match_count} out of #{(length_of_signature - 5)/3}")
	max_match_image
end

end