module Jekyll
   module StringFilter

    # String startsWith
    def startsWith(text, query)
      return text.start_with? query
    end

    # String endsWith
    def endsWith(text, query)
      return text.end_with? query
    end

  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
