return {
    {
        "github/copilot.vim"
    },
    {   -- "gc" to comment visual regions/lines 
        "numToStr/Comment.nvim",
        config = function ()
            -- Enable Comment.nvim
            require("Comment").setup()
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
      },
      { 
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
    },
}