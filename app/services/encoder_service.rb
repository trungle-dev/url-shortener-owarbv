# Encodes base10 (decimal) number to base62 string.
class EncoderService
  prepend SimpleCommand

  def initialize(num)
    @num = num
    @secret_keyset = ENV['secret_charset']
  end

  def call
    base62_encode
  end

  private

  def base62_encode
    return @secret_keyset[0] if @num == 0
    s = ''
    base = @secret_keyset.length
    while @num > 0
      s << @secret_keyset[ @num.modulo(base)]
      @num /= base
    end
    s.reverse
  end
end
