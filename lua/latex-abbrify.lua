local M = {}

local function get_tex_files()
    return vim.fn.glob(vim.fn.getcwd() .. '/**/*.tex', false, true)
end

local function extract_acronym_definitions(file_path)
    local acronyms = {}

    for line in io.lines(file_path) do
        -- TODO other forms, e.g., \acrodef{...}
        -- TODO "-" not supported in abbreviations?
        for acronym in line:gmatch("\\DeclareAcronym{([^{}%-]*)}") do
            table.insert(acronyms, acronym)
        end
    end

    return acronyms
end

local function main()
    -- TODO some clever caching would be nice
    local tex_files = get_tex_files()

    for _, file_path in ipairs(tex_files) do
        for _, acronym in ipairs(extract_acronym_definitions(file_path)) do
            local iabbrev_cmd = "iabbrev <buffer>"
            local acronym_plural = acronym .. "s"
            local ac = "\\ac{" .. acronym .. "}"
            local acp = "\\acp{" .. acronym .. "}"

            vim.cmd(iabbrev_cmd .. " " .. acronym .. " " .. ac)
            vim.cmd(iabbrev_cmd .. " " .. acronym_plural .. " " .. acp)
        end
    end
end

function M.setup()
    local augroup = vim.api.nvim_create_augroup("LaTeXAbbrify", { clear = true })
    -- TODO also on save
    vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWinEnter" },
        {
            group = augroup,
            desc = "LaTeX abbrify!",
            pattern = { "*.tex" },
            callback = main,
        }
    )
end

return M
