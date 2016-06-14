require "formula"

class Molsketch < Formula
  homepage "http://molsketch.sourceforge.net"
  url "https://downloads.sourceforge.net/project/molsketch/Molsketch/Carbon%200.2.0/Molsketch-0.2.0-Source.tar.gz"
  sha1 "a70205f89f0bcfcb280239ee51832ba34b8b15bd"

  depends_on "cmake" => :build
  depends_on "open-babel"
  depends_on "qt"
  depends_on "qt-assistant-compat"

  patch do
    url "https://raw.githubusercontent.com/zeld/patch/master/Molsketch_0.2.0_BuildPatch.patch"
    sha1 "9a6519e31bed5d2043e74673abc4926b398c75df"
  end

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DQT_ASSISTANT_LIBRARY=#{Formula["qt-assistant-compat"].opt_lib}/QtAssistant.framework/QtAssistant"
      args << "-DQT_ASSISTANT_INCLUDE=#{Formula["qt-assistant-compat"].opt_include}/QtAssistant/"
      system "cmake", "..", *args
      system "make"
      system "make install"
    end
  end

  test do
    system "false"
  end
end