class NetperfEnableDemo < Formula
  desc "Benchmarks performance of many different types of networking"
  homepage "https://github.com/kris-anderson/homebrew-netperf"
  url "https://github.com/HewlettPackard/netperf/archive/netperf-2.7.0.tar.gz"
  sha256 "4569bafa4cca3d548eb96a486755af40bd9ceb6ab7c6abd81cc6aa4875007c4e"
  head "https://github.com/HewlettPackard/netperf.git"

  def install
    inreplace "src/netlib.c" do |s|
      s.gsub! "inline void demo_interval_display(double actual_interval)", "void demo_interval_display(double actual_interval)"
      s.gsub! "inline void demo_interval_tick(uint32_t units)", "void demo_interval_tick(uint32_t units)"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--enable-demo",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/netperf -h | cat"
  end

end
