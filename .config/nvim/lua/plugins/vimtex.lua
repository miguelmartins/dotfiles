return {
  {
    "lervag/vimtex",
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
      --global vimtex settings
      vim.g.vimtex_imaps_enabled = 0 --i.e., disable them
      --vimtex_view_settings
      -- explicitly select the latexmk compiler
      vim.g.vimtex_compiler_method = "latexmk"

      -- configure latexmk to dump _all_ output into "out/"
      vim.g.vimtex_compiler_latexmk = {
        executable = "latexmk",
        -- let VimTeX supply -pdf, -synctex, etc.
        options = {
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
        },
        -- tell VimTeX that all output lives in ./out
        out_dir = "out", -- ⟵ this replaces '-outdir=out'
        aux_dir = "out", -- ⟵ (optional) similar for auxiliary files
      }
      vim.g.vimtex_compiler_latexmk_engines = {
        options = {
          "-pdf",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
        },
        -- tell VimTeX that all output lives in ./out
        out_dir = "out",               -- ⟵ this replaces '-outdir=out'
        aux_dir = "out",               -- ⟵ (optional) similar for auxiliary files
      }
      vim.g.vimtex_view_method =
      "sioyek"                         -- change this, depending on what you want to use..sumatraPDF, or skim, or zathura, or...
      vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
      --quickfix settings
      vim.g.vimtex_quickfix_open_on_warning = 0 --  don't open quickfix if there are only warnings
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
        "LaTeX Warning: .\\+ float specifier changed to",
        "Package hyperref Warning: Token not allowed in a PDF string",
      }
      vim.keymap.set("n", "<leader>vf", "<plug>(vimtex-view)", {})
      vim.keymap.set("n", "<leader>vc", "<plug>(vimtex-compile)", {})
    end,
  },
}
