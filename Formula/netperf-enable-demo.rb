class NetperfEnableDemo < Formula
  desc "Benchmarks performance of many different types of networking"
  homepage "https://github.com/kris-anderson/homebrew-netperf"
  url "https://kris-anderson.s3.us-west-2.amazonaws.com/homebrew-netperf/netperf-2.7.0.1.tar.gz"
  sha256 "53c9a2c68098eb80022272828f1f1439abc6214971673c0995ba7935c8547a54"
  head "https://github.com/HewlettPackard/netperf.git", branch: "master"

  depends_on "automake"

  def install
    inreplace "src/netcpu_osx.c" do |s|
      s.gsub! "/\* #include \<mach/mach_port\.h\> \*/", "#include \<mach/mach_port\.h\>"
      s.gsub! "mach_port_deallocate(lib_host_port);", "mach_port_deallocate(mach_task_self(), lib_host_port);"
    end

    system "./autogen.sh"
    # netperf 2.7's headers use K&R empty-paren declarations like
    # `extern void HIST_purge();`. Modern autoconf + Apple Clang now default to
    # -std=gnu23, where `()` means "(void)", so every call with arguments fails
    # with "too many arguments to function call". Pin to gnu17 (the last pre-C23
    # standard) where K&R declarations still compile. Passing CFLAGS here keeps
    # the build on gnu17 regardless of which standard the compiler defaults to.
    system "./configure", "--disable-dependency-tracking",
                          "--enable-demo",
                          "--prefix=#{prefix}",
                          "CFLAGS=-std=gnu17"
    system "make", "install"
  end

  test do
    system "#{bin}/netperf -h | cat"
  end
end
