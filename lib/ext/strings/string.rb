# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class String
  def localize(locale = TwitterCldr.get_locale)
    TwitterCldr::LocalizedString.new(self, locale)
  end
end

module TwitterCldr
  class LocalizedString < LocalizedObject

    # Uses wrapped string object as a format specification and returns the result of applying it to +args+ (see
    # +TwitterCldr.interpolate+ method for interpolation syntax).
    #
    # If +args+ is a Hash than pluralization is performed before interpolation (see +PluralFormatter+ class for
    # pluralization specification).
    #
    def %(args)
      pluralized = args.is_a?(Hash) ? @formatter.format(@base_obj, args) : @base_obj
      TwitterCldr.interpolate(pluralized, args)
    end

    def formatter_const
      TwitterCldr::Formatters::PluralFormatter
    end

  end
end