# frozen_string_literal: true

class Language
  class Output
    attr_reader :raw

    def initialize(raw = nil)
      @raw = raw
    end

    def self.from_raw(raw)
      if raw.is_a?(Array)
        new(raw.map { |element| from_raw(element) })
      elsif raw.is_a?(Hash)
        new(raw.transform_values { |value| from_raw(value) })
      else
        new(raw)
      end
    end

    def nil?
      raw.nil?
    end

    def to_raw
      if raw.is_a?(Array)
        raw.map(&:to_raw)
      elsif raw.is_a?(Hash)
        raw.transform_values(&:to_raw)
      else
        raw
      end
    end

    def clone
      Output.new(@raw.clone)
    end

    def present?
      !nil?
    end

    def ==(other)
      raw == (other.is_a?(Output) ? other.raw : other)
    end

    def to_s
      raw.to_s
    end

    def inspect
      raw.inspect
    end

    def []=(key, value)
      case @raw
      when NilClass
        @raw = { key => value }
      when String
        @raw = { key => value }
      when Array
        @raw << Output.new({ key => value })
      when Hash
        @raw[key] = value
      end
    end

    def merge(other)
      case @raw
      when NilClass
        @raw = other.raw
      when String
        case other.raw
        when String
          @raw += other.raw
        when Array
          @raw = other.raw
        when Hash
          @raw = other.raw
        end
      when Array
        case other.raw
        when String
          nil
        when Array
          @raw += other.raw
        when Hash
          @raw << other
        end
      when Hash
        case other.raw
        when String
          nil
        when Array
          nil
        when Hash
          @raw.merge!(other.raw)
        end
      end
    end

    def <<(other)
      case @raw
      when NilClass
        case other.raw
        when String
          @raw = [other]
        when Array
          @raw = [other]
        when Hash
          @raw = [other]
        end
      when String
        case other.raw
        when String
          @raw += other.raw
        when Array
          @raw = [other]
        when Hash
          @raw = [other]
        end
      when Array
        @raw << other
      when Hash
        case other.raw
        when String
          nil
        when Array
          nil
        when Hash
          @raw.merge!(other.raw)
        end
      end
    end
  end
end
