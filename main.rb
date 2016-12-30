require "./bit_map"
require "./bmp_filters"
file="./assets/test.bmp"
bitmap = BitMap.new(file)
bitmap_2 = BitMap.new(file)
bitmap_3 = BitMap.new(file)
bitmap.save("./output/out_raw.bmp")
BmpFilters.grey(bitmap)
bitmap.save("./output/out_grey.bmp")
BmpFilters.binarization(bitmap_2)

bitmap_2.save("./output/out_binary.bmp")

BmpFilters.contraryColor(bitmap_3)
bitmap_3.save("./output/out_contrary.bmp")
