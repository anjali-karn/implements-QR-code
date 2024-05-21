class Post < ApplicationRecord
    has_one_attached :qrcode, dependent: :destroy
  
    before_commit :generate_qrcode, on: :create
  
    private
  
    def generate_qrcode
      qr_content = "Title: #{self.title}\nBody: #{self.body}"
      qrcode = RQRCode::QRCode.new(qr_content)
  
      png = qrcode.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: "black",
        fill: "white",
        size: 120
      )
  
      self.qrcode.attach(
        io: StringIO.new(png.to_s),
        filename: "qrcode.png",
        content_type: "image/png"
      )
    end
  end
  