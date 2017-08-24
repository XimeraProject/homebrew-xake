class Xake < Formula
  desc "Build interactive math activities for Ximera"
  homepage "https://ximera.osu.edu/"
  url "https://github.com/XimeraProject/xake/archive/208768de7af0c019c1c6fc0a2a44cdf76a105599.tar.gz"
  version "0.8.28"
  sha256 "f35a78abc69874561a0f70f1489c283599cebd82b39b595175f7e65c16badaea"

  head "https://github.com/XimeraProject/xake.git"

  depends_on "go" => :build
  depends_on "pkg-config" => :build
  depends_on "libgit2" => :run
  depends_on "gnupg" => :run
  depends_on "mupdf" => :run
  
  # Git is a dependency because xake shells out a "git push" to publish content to the Ximera server.
  depends_on "git" => :run
  
  # also depends on tex
  # also depends on ximeraLatex

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = bin
    ENV["PKG_CONFIG_PATH"]=buildpath + "/src/github.com/libgit2/git2go/vendor/libgit2/build"
    ENV["CGO_CFLAGS"]="-I" + buildpath + "/src/github.com/libgit2/git2go/vendor/libgit2/include"
    system "go", "get", "-d", "github.com/libgit2/git2go"
    system "cd", buildpath + "/src/github.com/libgit2/git2go"
    system "git","submodule","update","--int"
    system "make","install-static"
    system "cd", buildpath
    system "go", "get", "-tags","static","."
    mv bin/"xake-628c13c44abc8343b913d2291cd0c356bd93f144", bin/"xake"
  end

  test do
    system "#{bin}/xake"
  end
end
