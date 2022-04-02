module Utils
  class JsonError < StandardError
    attr_reader :errors, :error_code

    def initialize(errors, error_code = 500)
      @errors = errors
      @error_code = error_code
    end

    def as_json(opts = {})
      errors_arr = []
      if errors.is_a? String
        return [{ message: errors }]
      end
    end
  end
end
