class Bazel032 < Formula
  desc "Google's own build tool"
  homepage "https://bazel.build/"
  url "https://github.com/bazelbuild/bazel/archive/0.3.2.tar.gz"
  sha256 "9692AC3318A40E8A0530F68BBFC473AE5F6A4A5C0FE08D2F88612CA4D40BA54A"
  head "https://github.com/bazelbuild/bazel.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4218898e8e2a65cc318b05b2f6a3f767f6778511abae05a4a339723b92457979" => :sierra
    sha256 "67f6bb36b71dc4183a550437b24895a83d8a682fc887e433af9623d23c9d694b" => :el_capitan
    sha256 "dea1f568cd632c67010bcdc0bd7e0ad512f9b9334e69b4dd4ad3a21796e06968" => :yosemite
  end

  depends_on :java => "1.8+"
  depends_on :macos => :yosemite

  def install
    ENV["EMBED_LABEL"] = "#{version}-homebrew"
    # Force Bazel ./compile.sh to put its temporary files in the buildpath
    ENV["BAZEL_WRKDIR"] = buildpath/"work"

    system "./compile.sh"
    system "./output/bazel", "--output_user_root", buildpath/"output_user_root",
           "build", "scripts:bash_completion"

    bin.install "scripts/packages/bazel.sh" => "bazel"
    bin.install "output/bazel" => "bazel-real"
    bash_completion.install "bazel-bin/scripts/bazel-complete.bash"
    zsh_completion.install "scripts/zsh_completion/_bazel"
  end

  test do
    touch testpath/"WORKSPACE"

    (testpath/"ProjectRunner.java").write <<-EOS.undent
      public class ProjectRunner {
        public static void main(String args[]) {
          System.out.println("Hi!");
        }
      }
    EOS

    (testpath/"BUILD").write <<-EOS.undent
      java_binary(
        name = "bazel-test",
        srcs = glob(["*.java"]),
        main_class = "ProjectRunner",
      )
    EOS

    system bin/"bazel", "build", "//:bazel-test"
    system "bazel-bin/bazel-test"
  end
end