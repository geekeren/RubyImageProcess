
class BmpFilters
  #灰度化图片
  def self.grey(bmp)
    for i in 0 .. bmp.height - 1
      for j in 0 .. bmp.width - 1
        rgb = bmp.getRGB(i, j)
        grey = rgb.getGreyLevel
        bmp.setRGB(i, j, RGB.new(grey, grey, grey))
      end
    end
  end

  #二值化图片
  def self.binarization(bmp)
    imageGreyLevel = bmp.getGreyLevel
    for i in 0 .. bmp.height - 1
      for j in 0 .. bmp.width - 1
        rgb = bmp.getRGB(i, j)
        if rgb.getGreyLevel<imageGreyLevel
          bmp.setRGB(i,j,RGB.new(0,0,0))
        else
          bmp.setRGB(i,j,RGB.new(255,255,255))
        end
      end

    end
  end

  #底片化图片
  def self.contraryColor(bmp)
    for i in 0 .. bmp.height - 1
      for j in 0 .. bmp.width - 1
        rgb = bmp.getRGB(i, j)
        bmp.setRGB(i, j, rgb.getContrary)
      end
    end
  end
end