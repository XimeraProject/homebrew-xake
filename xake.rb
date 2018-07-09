class Xake < Formula
  desc "Build interactive math activities for Ximera"
  homepage "https://ximera.osu.edu/"
  url "https://github.com/XimeraProject/xake/archive/1182864e966ec5285221deed0581b2b87ea752f7.tar.gz"
  version "0.9.2"
  sha256 "7718452c43d7cf72388284df017bdb71f95e58db8452014b25f79ff47eec009d"

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
    system "ls bin"
    #mv bin/"xake-1182864e966ec5285221deed0581b2b87ea752f7", bin/"xake"
  end

  test do
    system "#{bin}/xake"
  end
end
