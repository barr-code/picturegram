module ApplicationHelper
  def hashtagify(string)
    string.gsub(/(?:#(\w+))/) {link_to_hashtag($1)}
  end

  def link_to_hashtag(string)
    link_to "##{string}", posts_path(search: string)
  end
end
