class ForgeHarness < Formula
  desc "FH governance gate for Claude/Codex — machine-parseable verdict CLI"
  homepage "https://github.com/chrono-meta/forge-harness"
  url "https://registry.npmjs.org/@chrono-meta/fh-gate/-/fh-gate-3.25.1.tgz"
  sha256 "5af4244825138b3d9a7418023768f635d6623e09a3e1a7605b77f95afbc6fffa"
  license "MIT"

  bottle do
    root_url "https://github.com/chrono-meta/homebrew-forge-harness/releases/download/forge-harness-3.24.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c9b0e063f5092cafff3e1636ff5454a5f661402ecb00a65c39f8d9eb79581eaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dd145c7fc0f7b5ebb101389651354735b1b663201a7b25814afeb448595b484e"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # fh-gate shells out to a live `claude`/`codex` backend for a real review — a `brew test`
    # sandbox has neither configured, so this test must never trigger that path (it would hang
    # or fail on missing credentials, not prove the binary itself works). A deliberately
    # nonexistent target file exercises the fail-closed path deterministically, with no network
    # call: "0 of 1 target file(s) could be read" — proves the binary runs and its CLI parsing
    # works, without depending on an LLM backend being present in CI.
    output = shell_output("#{bin}/fh-gate __definitely_missing_file__.txt 2>&1", 10)
    assert_match "Failing closed", output
  end
end
