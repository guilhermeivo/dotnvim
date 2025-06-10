local M = {}

function M.setup(options)
	vim.api.nvim_create_autocmd("BufModifiedSet", {
		pattern = { "*" },
		callback = function()
			if not (vim.bo) then
				return
			end
			
			opts = {}
			opts["text"] = "｜"
			opts["texthl"] = "GitGutterChange"
			vim.fn.sign_define("GitChange", opts)

			require("gitdiff.ui").update()
		end,
		group = vim.api.nvim_create_augroup("signcolumn", { clear = false })		
	})
end

return M 
