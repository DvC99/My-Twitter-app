module TweetsHelper
    def render_with_hashtags(body)
        body.gsub(/#\w+/){|word| link_to word, hashtags_path(word.downcase.delete('#'))}.gsub(/@\w+/){|word| link_to word, profile_path(word.delete('@'))}.html_safe   
    end
    
end
