module PostsHelper
  def render_with_hashtags(hash_word)
      hash_word.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post/hashtag/#{word.delete("#")}"}.html_safe
  end
end
