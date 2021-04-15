module Jekyll

  module Drops
    class UrlDrop < Drop
      def simple_path
        post_root = Pathname.new('_posts')
        Pathname.new(@obj.relative_path).relative_path_from(post_root).dirname.to_s
      end
    end
  end

end
