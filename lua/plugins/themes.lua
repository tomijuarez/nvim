return {
    {
        -- https://github.com/rebelot/kanagawa.nvim
        "rebelot/kanagawa.nvim",
        lazy = false,
        opts = {
          transparent = true,
          background = {
            dark = "dragon"
          },
          colors = {
            theme = {
              all = {
                ui = {
                  float = { bg = "none" },
                    bg_gutter = "none",
                },
              },
            }
          },
          overrides = function(colors)
            return {
                String = { fg = colors.palette.lightBlue, italic = true },
                -- method name
                ["@lsp.type.method.java"] = {
                  fg = colors.palette.sakuraPink
                },
                ["@lsp.type.modifier.java"] = {
                  fg = colors.palette.springBlue
                },
                -- annotation
                ["@attribute"] = { fg = colors.palette.springViolet2}, -- @
                ["@lsp.typemod.annotation.public.java"] = { fg = colors.palette.springViolet2 }, -- Annotation type
                -- parameters
                ["@lsp.type.parameter.java"] = { fg = colors.palette.fujiWhite },
                ["@lsp.mod.readonly.java"] = { fg = colors.palette.fujiWhite },
    
                ["@lsp.typemod.class.readonly.java"] = { fg = colors.palette.waveAqua2 },
                ["@lsp.typemod.enum.readonly.java"] = { fg = colors.palette.waveAqua2 }
            }
        end,
        },
        config = function(_, opts)
          require("kanagawa").setup(opts) -- Replace this with your favorite colorscheme
          vim.cmd("colorscheme kanagawa-wave")
        end
    }
}