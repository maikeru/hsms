#!/usr/bin/env ruby

module Hsms
  class Packet
    def initialize length, header, message
      @length_bytes = length
      @header = header
      @message = message
    end

    def length
      @length_bytes.unpack 'H*'
    end

    def device_id
      device_bytes = @header.byteslice 0, 2
      device_bytes.unpack 'H*'
    end
    def stream
      device_bytes = @header.byteslice 2, 1
      device_bytes.unpack 'H*'
    end
    def function
      device_bytes = @header.byteslice 3, 1
      device_bytes.unpack 'H*'
    end
    def s_type
      device_bytes = @header.byteslice 5, 1
      device_bytes.unpack 'H*'
    end

    def type
      if s_type.eql? ["00"]
        "data"
      elsif s_type.eql? ["01"]
        "select.req"
      elsif s_type.eql? ["02"]
        "select.rsp"
      elsif s_type.eql? ["05"]
        "linktest.req"
      elsif s_type.eql? ["06"]
        "linktest.rsp"
      elsif s_type.eql? ["09"]
        "separation.req"
      else
        "UNDEFINED"
      end
    end

    def to_s
      puts
      puts @length_bytes.unpack 'H*'
      puts @header.unpack 'H*'
      puts @message.unpack 'H*'
    end
  end
end

# bytesize [4]
# ["0000000a"]
# bytesize [14]
# ["ffff00000001000000d80000000a"]
# bytesize [10]
# ["ffff00000001000000d9"]

