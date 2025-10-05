local cmp = require "cmp"
local luasnip = require "luasnip"

require("luasnip.loaders.from_vscode").lazy_load()

-- Opsional: prioritaskan [Copilot] di atas dengan comparator khusus
local has_copilot_cmp, copilot_cmp = pcall(require, "copilot_cmp.comparators")

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },

    -- Penting: Tab tetap indent ketika tidak ada menu/snippet,
    -- dan berfungsi untuk navigasi completion/snippet saat ada.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback() -- kirim Tab biasa -> indent
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources {
    { name = "copilot" }, -- dari copilot-cmp
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- butuh plugin 'cmp_luasnip'
    { name = "buffer" },
    { name = "path" },
  },
  sorting = has_copilot_cmp and {
    priority_weight = 2,
    comparators = {
      copilot_cmp.prioritize,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  } or nil,
}

-- Opsional: integrasi dengan nvim-autopairs saat confirm
pcall(function()
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end)
