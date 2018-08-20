class Xake < Formula
  desc "Build interactive math activities for Ximera"
  homepage "https://ximera.osu.edu/"
  url "https://github.com/XimeraProject/xake/archive/v0.9.3.tar.gz"
  version "0.9.3"
  sha256 "611f240103c8ac8dbac36fd497566f8040f247e312f3ae0fd34848ff6da81389"

  head "https://github.com/XimeraProject/xake.git"

  depends_on "go" => :build
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libgit2"
  depends_on "gnupg"
  depends_on "mupdf"
  
  # Git is a dependency because xake shells out a "git push" to publish content to the Ximera server.
  depends_on "git"
  
  # also depends on tex
  # also depends on ximeraLatex

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = bin
    ENV["PKG_CONFIG_PATH"]=buildpath + "/src/github.com/libgit2/git2go/vendor/libgit2/build"
    ENV["CGO_CFLAGS"]="-I" + buildpath + "/src/github.com/libgit2/git2go/vendor/libgit2/include"
    system "go", "get", "-d", "github.com/libgit2/git2go"
    Dir.chdir(ENV["GOPATH"]+"/src/github.com/libgit2/git2go")
    system "git","submodule","update","--init"
    system "make","install-static"
    Dir.chdir(ENV["GOPATH"])
    system "go", "get", "-tags","static","."
    mv bin/"xake-0.9.3", bin/"xake"
  end

  test do
    system "#{bin}/xake"
  end
end
