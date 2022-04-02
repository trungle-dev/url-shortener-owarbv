# Encodes base10 (decimal) number to base62 string.
class EncoderService
  prepend SimpleCommand

  SECRET_CHARSET = ENV['secret_charset']

  def initialize(num)
    @num = num
  end

  def call
    base62_encode
  end

  private

  def base62_encode
    return SECRET_CHARSET[0] if @num == 0
    s = ''
    base = SECRET_CHARSET.length
    while @num > 0
      s << SECRET_CHARSET[@num.modulo(base)]
      @num /= base
    end
    s.reverse
  end
end
