local M = {
    scan_count = 0,
    acronyms = {}
}

local function get_tex_files()
    return vim.fn.glob(vim.fn.getcwd() .. '/**/*.tex', true, true)
end

local function extract_acronym_definitions(file_path)
    for line in io.lines(file_path) do
        -- TODO other forms, e.g., \acrodef{...}
        -- TODO "-" not supported in abbreviations?
        for acronym in line:gmatch("\\DeclareAcronym{([^{}%-]*)}") do
            M.acronyms[acronym] = true
        end
    end
end

local function set_abbreviations()
    for acronym, _ in pairs(M.acronyms) do
        local iabbrev_cmd = "iabbrev"
        local acronym_plural = acronym .. "s"
        local ac = "\\ac{" .. acronym .. "}"
        local acp = "\\acp{" .. acronym .. "}"

        vim.cmd(iabbrev_cmd .. " " .. acronym .. " " .. ac)
        vim.cmd(iabbrev_cmd .. " " .. acronym_plural .. " " .. acp)
    end
end

local function handle_write()
    extract_acronym_definitions(vim.fn.expand("%"))
    set_abbreviations()
end

local function initialize()
    M.scan_count = M.scan_count + 1
    local tex_files = get_tex_files()
    for _, file_path in ipairs(tex_files) do
        extract_acronym_definitions(file_path)
    end
    set_abbreviations()
end

function M.setup()
    local augroup = vim.api.nvim_create_augroup("LaTeXAbbrify", { clear = true })

    vim.api.nvim_create_autocmd(
        { "BufEnter" },
        {
            group = augroup,
            desc = "LaTeX abbrify init",
            pattern = { "*.tex" },
            callback = initialize,
            once = true,
        }
    )

    vim.api.nvim_create_autocmd(
        { "BufWritePost" },
        {
            group = augroup,
            desc = "LaTeX abbrify update",
            pattern = { "*.tex" },
            callback = handle_write,
        }
    )
end

return M
