local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end


-- add new formatters and linters under sources.
null_ls.setup({
	debug = false,
	sources = {
		null_ls.builtins.formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
		null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.clang_format,
	},
})
