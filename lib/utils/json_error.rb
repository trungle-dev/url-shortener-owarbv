module Utils
  class JsonError < StandardError
    attr_reader :errors, :error_code

    def initialize(errors, error_code = 500)
      super(errors)

      @errors = errors
      @error_code = error_code
    end

    def as_json(_opts = {})
      if errors.is_a? String
        [{ message: errors }]
      elsif errors.is_a? Array
        errors.map do |msg|
          if msg.is_a? String
            { message: msg }
          else
            { message: msg.to_s }
          end
        end
      end
    end
  end
end
