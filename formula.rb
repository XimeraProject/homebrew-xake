class Xake < Formula
  desc "Build interactive math activities for Ximera"
  homepage "https://ximera.osu.edu/"
  url "https://github.com/XimeraProject/xake/archive/628c13c44abc8343b913d2291cd0c356bd93f144.tar.gz"
  version "0.5.2"
  sha256 "4c61a0e5a85dd8b3e7e4cd31d6ca394bc40bc24490589c17708adcf6ae47c9b8"

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

    # Install Go dependences
    system "go", "get", "."
    # system "go", "build", "-o", "xake" 
    mv bin/"xake-628c13c44abc8343b913d2291cd0c356bd93f144", bin/"xake"
  end

  test do
    system "#{bin}/xake"
  end
end