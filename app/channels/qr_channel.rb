class QrChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'qr_channel'
  end

  def unsubscribed
    # Cleanup when channel is unsubscribed
  end
end