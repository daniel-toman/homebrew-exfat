class Exfat < Formula
  desc "Free exFAT file system implementation"
  homepage "https://github.com/relan/exfat"

  head do
    url "https://github.com/relan/exfat.git"

    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on 'pkg-config' => :build
  end

  def install
    system "autoreconf", "-fiv"
    ENV.append_path "PKG_CONFIG_LIBDIR", "#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
