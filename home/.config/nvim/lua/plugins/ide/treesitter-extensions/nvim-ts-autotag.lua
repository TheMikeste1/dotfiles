return {
  'windwp/nvim-ts-autotag',
  cond = not VSCODE,
  ft = {
    "astro",
    "glimmer",
    "handlebars",
    "html",
    "javascript",
    "jsx",
    "markdown",
    "php",
    "rescript",
    "svelte",
    "tsx",
    "typescript",
    "vue",
    "xml",
  },
  config = function()
    require('nvim-ts-autotag').setup()
  end,
}
