class Block
  DIFFICULTY = '000'

  attr_reader :hash
  attr_reader :nonce

  def self.first(data = 'Genesis')
    Block.new(data, '0')
  end

  def initialize(data, previous_hash)
    @data = data
    @previous_hash = previous_hash
    @hash = calculate_hash
  end

  def calculate_hash
    calc_hash_with_nonce(nonce_value)
  end

  def nonce_value
    @nonce ||= begin
      nonce = 0
      nonce += 1 until valid_nonce?(nonce)
      nonce
    end
  end

  def valid_nonce?(nonce)
    calc_hash_with_nonce(nonce).start_with?(DIFFICULTY)
  end

  def calc_hash_with_nonce(nonce = 0)
    Digest::SHA256.hexdigest(nonce.to_s + @data + @previous_hash)
  end
end