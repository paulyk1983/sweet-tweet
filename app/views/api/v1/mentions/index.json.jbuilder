json.array! @mentions.each do |mention|
  json.created_at mention.created_at
end