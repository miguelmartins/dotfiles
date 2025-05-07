local function math()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

local visualSelectionOrInsert = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, t(parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

local math_string_pattern = [[[\\%w%.%_%-%"%']+$]]
return {
	s({
		trig = ";a",
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("\\alpha") }),
	s({ trig = '"', snippetType = "autosnippet", desc = "quotation marks" }, fmta([[``<>'' ]], { i(1, "text") })),
	s(
		{ trig = "fig", snippetType = "snippet", dscr = "A basic figure environment" },
		fmta(
			[[
        \begin{figure}
        \centering
        \includegraphics[width=0.9\linewidth]{<>}
        \caption{
            \textbf{<>}
            <>
            }
        \label{fig:<>}
        \end{figure}

        ]],
			{ i(1, "filename"), i(2, "captionBold"), i(3, "captionText"), i(4, "figureLabel") }
		)
	),
	s(
		{ trig = "emph", dscr = "the emph command, either in insert mode or wrapping a visual selection" },
		fmta("\\emph{<>}", { d(1, visualSelectionOrInsert) })
	),
	s(
		{ trig = "textbf", dscr = "the textbf command, either in insert mode or wrapping a visual selection" },
		fmta("\\textbf{<>}", { d(1, visualSelectionOrInsert) })
	),
	s(
		{ trig = "env", snippetType = "snippet", dscr = "Begin and end an arbitrary environment" },
		fmta(
			[[
        \begin{<>}
            <>
        \end{<>}
        ]],
			{ i(1), i(2), rep(1) }
		)
	), --postfixes for vectors, hats, etc. The match pattern is '\\' plus the default (so that hats get put on greek letters,e.g.)
	postfix({
		trig = "hat",
		match_pattern = math_string_pattern,
		snippetType = "autosnippet",
		dscr = "postfix hat when in math mode",
	}, { l("\\hat{" .. l.POSTFIX_MATCH .. "}") }, { condition = math }),
	postfix({
		trig = "vec",
		match_pattern = [[[\\%w%.%_%-%"%']+$]],
		snippetType = "autosnippet",
		dscr = "postfix vec when in math mode",
	}, { l("\\vec{" .. l.POSTFIX_MATCH .. "}") }, { condition = math }),
	postfix({
		trig = "mcal",
		match_pattern = math_string_pattern,
		snippetType = "autosnippet",
		dscr = "postfix mathcal when in math mode",
	}, { l("\\mathcal{" .. l.POSTFIX_MATCH .. "}") }, { condition = math }),
	postfix({
		trig = "mbb",
		match_pattern = math_string_pattern,
		snippetType = "autosnippet",
		dscr = "postfix mathbb when in math mode",
	}, { l("\\mathbb{" .. l.POSTFIX_MATCH .. "}") }, { condition = math }),
	postfix({
		trig = "mbf",
		match_pattern = math_string_pattern,
		snippetType = "autosnippet",
		dscr = "postfix beefy when in math mode",
	}, { l("\\mathbf{" .. l.POSTFIX_MATCH .. "}") }, { condition = math }),
	postfix({
		trig = "mbs",
		match_pattern = math_string_pattern,
		snippetType = "autosnippet",
		dscr = "postfix boldsymbol when in math mode",
	}, { l("\\boldsymbol{" .. l.POSTFIX_MATCH .. "}") }, { condition = math }),
	s(
		"textbf",
		f(function(args, snip)
			local res, env = {}, snip.env
			for _, ele in ipairs(env.LS_SELECT_RAW) do
				table.insert(res, "\\textbf{" .. ele .. "}")
			end
			return res
		end, {})
	),
	s(
		{
			trig = ";I",
			snippetType = "autosnippet",
			desc = "integral with infinite or inserted limits",
			wordTrig = false,
		},
		fmta(
			[[
        <>
        ]],
			{
				c(1, {
					t("\\int_{-\\infty}^\\infty"),
					sn(nil, fmta([[ \int_{<>}^{<>} ]], { i(1), i(2) })),
				}),
			}
		)
	),
}
