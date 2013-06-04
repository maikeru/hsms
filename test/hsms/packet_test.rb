require 'minitest/autorun'
require_relative '../../lib/hsms/packet'

describe Hsms::Packet do
  let(:packet) do
    length = ["0000000a"].pack "H*"
    header = ["ffff00000001000000d80000000a"].pack "H*"
    message = ["ffff00000001000000d9"].pack "H*"
    Hsms::Packet.new length, header, message
  end

  it '#type' do
    packet.type.must_equal "select.req"
  end
end
