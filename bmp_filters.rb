class BmpFilters
  #灰度化图片
  #取RGB三色平均值
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
  #小于一定阈值设为0 0 0，大于设置为255 255 255
  def self.binarization(bmp)
    imageGreyLevel = bmp.getGreyLevel
    for i in 0 .. bmp.height - 1
      for j in 0 .. bmp.width - 1
        rgb = bmp.getRGB(i, j)
        if rgb.getGreyLevel<imageGreyLevel
          bmp.setRGB(i, j, RGB.new(0, 0, 0))
        else
          bmp.setRGB(i, j, RGB.new(255, 255, 255))
        end
      end

    end
  end

  #底片化图片
  #RGB取反色255-
  def self.contraryColor(bmp)
    for i in 0 .. bmp.height - 1
      for j in 0 .. bmp.width - 1
        rgb = bmp.getRGB(i, j)
        bmp.setRGB(i, j, rgb.getContrary)
      end
    end
  end

  #浮雕效果
  #浮雕的算法相对复杂一些，用当前点的RGB值减去相邻点的RGB值并加上128作为新的RGB值。由于图片中相邻点的颜色值是比较接近的，
  #因此这样的算法 处理之后，只有颜色的边沿区域，也就是相邻颜色差异较大的部分的结果才会比较明显，而其他平滑区域则值都接近128左右，
  #也就是灰色，这样就具有了浮雕效果。
  #在实际的效果中，这样处理后，有些区域可能还是会有”彩色”的一些点或者条状痕迹，所以最好再对新的RGB值做一个灰度处理。
  def self.emboss(bmp)

    preRGB=RGB.new(128, 128, 128)

    for i in 0 .. bmp.height - 1
      for j in 0 .. bmp.width - 1
        currentRGB=bmp.getRGB(i, j)
        r=(currentRGB.r-preRGB.r)*1+128
        g=(currentRGB.g - preRGB.g)*1+128
        b=(currentRGB.b-preRGB.b)*1+128

        bmp.setRGB(i, j, RGB.new(r,g,b).getGreyRGB)
        preRGB = currentRGB
      end
    end

  end

end