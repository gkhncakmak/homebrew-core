class Qcachegrind < Formula
  desc "Visualize data generated by Cachegrind and Calltree"
  homepage "https://kcachegrind.github.io/"
  url "https://download.kde.org/stable/release-service/22.12.2/src/kcachegrind-22.12.2.tar.xz"
  sha256 "1360375ab12acff6cfa52de68d020b1908474c15552c2775ac575c569eb8b418"
  license "GPL-2.0-or-later"

  # We don't match versions like 19.07.80 or 19.07.90 where the patch number
  # is 80+ (beta) or 90+ (RC), as these aren't stable releases.
  livecheck do
    url "https://download.kde.org/stable/release-service/"
    regex(%r{href=.*?v?(\d+\.\d+\.(?:(?![89]\d)\d+)(?:\.\d+)*)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "2d097c8a98d0b69e2308dc6541c5aaf3d8d84b51e279475522e3ec425963a2c7"
    sha256 cellar: :any,                 arm64_monterey: "2d097c8a98d0b69e2308dc6541c5aaf3d8d84b51e279475522e3ec425963a2c7"
    sha256 cellar: :any,                 arm64_big_sur:  "42a6891cd59bd52b23c8cc731e168dfc8ccc23188aa07540ebb5113d610820ff"
    sha256 cellar: :any,                 ventura:        "cf7b7626118a4fbe464274212172295d9401c628256c0724fbc3037461330c6f"
    sha256 cellar: :any,                 monterey:       "cf7b7626118a4fbe464274212172295d9401c628256c0724fbc3037461330c6f"
    sha256 cellar: :any,                 big_sur:        "1bde64b823f9457cfebda9851e06150efa7a5bcb377184d3c312a00f504ffc5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "be443ecf31ef11022179b87e642ff4f614c8439dbcec4fc6353a2755ad784c37"
  end

  depends_on "graphviz"
  depends_on "qt@5"

  fails_with gcc: "5"

  def install
    args = []
    if OS.mac?
      # TODO: when using qt 6, modify the spec
      spec = (ENV.compiler == :clang) ? "macx-clang" : "macx-g++"
      args = %W[-config release -spec #{spec}]
    end

    system Formula["qt@5"].opt_bin/"qmake", *args
    system "make"

    if OS.mac?
      prefix.install "qcachegrind/qcachegrind.app"
      bin.install_symlink prefix/"qcachegrind.app/Contents/MacOS/qcachegrind"
    else
      bin.install "qcachegrind/qcachegrind"
    end
  end
end
