class String
  def comment_line?
    self =~ /^\s*\/\*/
  end
end

class CSSCompressor
  def initialize(filename)
    @filename = filename
  end

  def compress_to(dstfile)
    ofile = File.new(dstfile,"w")
    File.readlines(@filename).each do |line|
      ofile.write(line) unless line.comment_line? || line !~ /\S/ 
    end
  end
end
