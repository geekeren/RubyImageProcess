class RGB
  def r
    @R
  end

  def g
    @G
  end

  def b
    @B
  end

  def initialize(r, g, b)
    @R=r
    @G=g
    @B=b
  end

  def getGreyLevel
    getGreyLevelWithWeight(0.3, 0.59, 0.11)
  end

  def getGreyLevelWithWeight(rWeight, gWeight, bWeight)
    (@R.to_f * rWeight + @G.to_f * rWeight + @B.to_f * bWeight).to_i
  end

  def getContrary
    RGB.new(255-@R, 255-@G, 255-@B)
  end

  def getGreyRGB
    grey = getGreyLevel
    RGB.new(grey, grey, grey)
  end
end