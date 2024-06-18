return {
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("harpoon"):setup{}
        end,
      },
}