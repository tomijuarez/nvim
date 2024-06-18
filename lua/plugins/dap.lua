return {
    {
        "rcarriga/nvim-dap-ui", 
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function()
            require("dapui").setup()
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    },
    {
        "leoluz/nvim-dap-go",
        config = function()
            require("dap-go").setup()
        end
    }
}
