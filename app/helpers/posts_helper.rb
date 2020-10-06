module PostsHelper
  def render_with_hashtags(introduction)
    introduction.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/post/hashtag/#{word.delete("#")}"}.html_safe
  end

  def introduction_placeholder
  <<-"EOS".strip_heredoc
    キャプションを書きましょう
    #でタグ付けできます
  EOS
  end
end