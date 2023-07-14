class NetperfEnableDemo < Formula
  desc "Benchmarks performance of many different types of networking"
  homepage "https://github.com/kris-anderson/homebrew-netperf"
  url "https://kris-anderson.s3.us-west-2.amazonaws.com/homebrew-netperf/netperf-2.7.0.1.tar.gz"
  sha256 "718d70c9205b598e1007ba5587e4954a5c120a958de860773dd570efdee11620"
  head "https://github.com/HewlettPackard/netperf.git", branch: "master"

  def install
    inreplace "src/netcpu_osx.c" do |s|
      s.gsub! "/\* #include \<mach/mach_port\.h\> \*/", "#include \<mach/mach_port\.h\>"
      s.gsub! "mach_port_deallocate(lib_host_port);", "mach_port_deallocate(mach_task_self(), lib_host_port);"
    end

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--enable-demo",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/netperf -h | cat"
  end
end
