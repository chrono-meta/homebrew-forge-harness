class ForgeHarness < Formula
  desc "FH governance gate for Claude/Codex — machine-parseable verdict CLI"
  homepage "https://github.com/chrono-meta/forge-harness"
  url "https://registry.npmjs.org/@chrono-meta/fh-gate/-/fh-gate-3.9.0.tgz"
  sha256 "c8d3d36441839143e00de3b76e08e6c0be8dd5c964477d1c4f7e3b21099984e6"
  license "MIT"

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
