module Wired
  # The Wired Cipher class is an abstraction of the 
  # ruby OpenSSL cipher features. 
  #
  # @author Rafaël Warnault (mailto:dev@read-write.fr)
  class Cipher
    require 'openssl'

    RSA_PKCS1_OAEP_PADDING  = 4

    # return [Wired::Socket::Cipher] A valid socket cipher
    attr_accessor :cipher
    # return [OpenSSL::Cipher] A ruby OpenSSL cipher object
    attr_reader   :ssl_cipher

    attr_reader   :cipher_key
    attr_reader   :cipher_iv

    # Initialize a new cipher object
    #
    # @param cipher [Wired::Socket::Cipher] A valid socket cipher
    #
    # @return [Wired::Cipher] A Wired cipher instance
    def initialize(cipher)
      @ssl_cipher = Wired::Cipher::ssl_cipher(cipher)

        @ssl_cipher.key = @cipher_key   = @ssl_cipher.random_key
        @ssl_cipher.iv  = @cipher_iv  = @ssl_cipher.random_iv

        @ssl_cipher.padding = RSA_PKCS1_OAEP_PADDING
    end


    def encrypt(data)
      @ssl_cipher.encrypt
      @ssl_cipher.key = @cipher_key
      @ssl_cipher.iv  = @cipher_iv 
      return @ssl_cipher.update(data) + @ssl_cipher.final
    end


    def decrypt(data)
      @ssl_cipher.decrypt
      @ssl_cipher.key = @cipher_key
      @ssl_cipher.iv  = @cipher_iv 
      return @ssl_cipher.update(data) + @ssl_cipher.final
    end



    def block_size
      return @ssl_cipher.block_size
    end
    

    # A class method that returns an OpenSSL::Cipher 
    # instance, for a given Cipher::CONST
    def self.ssl_cipher(const)
      case const
      when Wired::Socket::Cipher::NONE
        cipher =  nil
      when Wired::Socket::Cipher::RSA_AES_128
        cipher =  OpenSSL::Cipher::Cipher.new('AES-128-CBC')
      when Wired::Socket::Cipher::RSA_AES_192
        cipher =  OpenSSL::Cipher::Cipher.new('AES-192-CBC')
      when Wired::Socket::Cipher::RSA_AES_256
        cipher =  OpenSSL::Cipher::Cipher.new('AES-256-CBC')
      when Wired::Socket::Cipher::RSA_BF_128
        cipher =  OpenSSL::Cipher::Cipher.new('BF-CBC')
      when Wired::Socket::Cipher::RSA_3DES_192
        cipher =  OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC')
      end
      return cipher
    end

  end
end