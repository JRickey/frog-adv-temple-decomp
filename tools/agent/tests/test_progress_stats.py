import unittest

from tools.agent import progress_stats


class ProgressStatsLabelsTests(unittest.TestCase):
    def test_legacy_scan_does_not_claim_reconstruction_completion(self):
        functions = progress_stats.FunctionCounts(100, 10, 20, 90, 120, 2, 110)
        data = progress_stats.DataStats(1000, 100, 200, 3)
        human = progress_stats.render_human(functions, data)
        readme = progress_stats.render_readme_section(functions, data)
        for output in (human, readme):
            self.assertNotIn("true pure-C", output)
            self.assertNotIn("Functions decompiled to C", output)
            self.assertNotIn("data deblob", output.lower())
            self.assertIn("not reconstructed-data completion", output)
        self.assertIn("not linked census", human)
        self.assertIn("not a linked-function census", readme)


if __name__ == "__main__":
    unittest.main()
