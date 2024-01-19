return {
  "Weissle/persistent-breakpoints.nvim",
  cond = not VSCODE,
  opts = {
    load_breakpoints_event = { "BufReadPost" },
  }
}
