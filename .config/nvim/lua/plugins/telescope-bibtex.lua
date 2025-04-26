return { "nvim-telescope/telescope-bibtex.nvim",
  dependecies = {
    {'nvim-telescope/telescope.nvim'},
  },
  config = function ()
    require"telescope".load_extension("bibtex")
  end,
}
