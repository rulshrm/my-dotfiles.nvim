local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("php", {
  s("route", {
    t("Route::"), i(1, "get"), t("('"), i(2, "path"), t("', "), 
    t("["), i(3, "Controller"), t("::class, '"), i(4, "method"), t("']);")
  }),
  s("controller", {
    t("public function "), i(1, "method"), t("(Request $request)\n{\n    "),
    i(0), t("\n}")
  }),
  -- Add more snippets as needed
})