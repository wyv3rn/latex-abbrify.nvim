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
    local tex_files = get_tex_files()

    for _, file_path in ipairs(tex_files) do
        for _, acronym in ipairs(extract_acronym_definitions(file_path)) do
            local abbreviation_cmd = "iab " .. acronym .. " \\ac{" .. acronym .. "}"
            print(abbreviation_cmd)
            vim.cmd(abbreviation_cmd)
        end
    end
end

function M.setup()
    local augroup = vim.api.nvim_create_augroup("LaTeXAbbrify", { clear = true })
    vim.api.nvim_create_autocmd(
        "VimEnter",
        { group = augroup, desc = "LaTeX abbrify!", once = true, callback = main }
    )
end

return M
