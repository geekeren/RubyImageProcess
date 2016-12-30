require './lib/rgb.rb'
class BitMap

  def initialize(file)
    @file = File.open(file, "rb+")
    @bitMapFileHeader = @file.read(14).unpack('a2LS2L')

    @type=@bitMapFileHeader[0] #文件类型，BM：BMP图片

    if @type!="BM"
      puts "不是BMP图片"
      exit
    end

    @size=@bitMapFileHeader[1] #文件大小
    @offBits=@bitMapFileHeader[4] #图像数据的偏移字节
    @bitMapInfoHeader = @file.read(40).unpack('L3S2L6')

    @infoSize=@bitMapInfoHeader[0] #图片信息字段大小
    @width=@bitMapInfoHeader[1] #图片宽度
    @height=@bitMapInfoHeader[2] #图片高度
    @planes=@bitMapInfoHeader[3] #平面数
    @bitCountPerPixel=@bitMapInfoHeader[4] #图片位数
    @compression=@bitMapInfoHeader[5]
    @imageDataSize=@bitMapInfoHeader[6] #图片数据段大小
    @xPelsPerMeter=@bitMapInfoHeader[7]
    @yPelsPerMeter=@bitMapInfoHeader[8]
    @ClrUsed=@bitMapInfoHeader[9]
    @ClrImportant=@bitMapInfoHeader[10]
    @skipByteALine = 4 - ((@width * @bitCountPerPixel)>>3) & 3
    if @bitCountPerPixel == 24

      iLineByteCnt = (((@width * @bitCountPerPixel) + 31) >> 5) << 2
      @file.seek @offBits
      @imageDataArray= @file.read(@imageDataSize).unpack("C*")
    end
  end

  def width
    @width
  end

  def height
    @height
  end

  #图片（i，j）位置的RGB,二维坐标到一维坐标的映射，同时考虑到一个像素的位数以及skip量
  def getRGB(i, j)
    linearIndex = (@width*i+j)*(@bitCountPerPixel>>3)+i*@skipByteALine
    RGB.new(@imageDataArray[linearIndex+2], @imageDataArray[linearIndex+1], @imageDataArray[linearIndex])
  end

  def setRGB(i, j, rgb)
    linearIndex = (@width*i+j)*(@bitCountPerPixel>>3)+i*@skipByteALine
    @imageDataArray[linearIndex+2] = rgb.r
    @imageDataArray[linearIndex+1] = rgb.g
    @imageDataArray[linearIndex] = rgb.b
  end

  def save(file)
    @saveFile = File.open(file, "wb")
    @saveFile.write(@bitMapFileHeader.pack('a2LS2L'))
    @saveFile.write(@bitMapInfoHeader.pack('L3S2L6'))
    @saveFile.write(@imageDataArray.pack('C*'))
    @file.close
    @saveFile.close
  end



  def getGreyLevel
    greyLevel=0
    for i in 0 .. @height - 1
      tmpGreyLevel=0
      for j in 0 .. @width - 1
        rgb = getRGB(i, j)
        tmpGreyLevel+=rgb.getGreyLevel
      end
      greyLevel+=tmpGreyLevel/@width
    end
    greyLevel/@height
  end


end


