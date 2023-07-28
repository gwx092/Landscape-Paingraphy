module Public::PostsHelper
  def render_with_tags(body)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post/tag/#{word.delete("＃").delete("#")}"}.html_safe
  end
end
