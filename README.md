# LaTeXAbbrify

LaTeXAbbrify is a Neovim plugin designed to streamline the usage of acronyms in your LaTeX workspace.
It automatically searches for acronym definitions in your LaTeX documents and creates vim abbreviations for efficient typing.

## Disclaimer

This plugin is currently under development.
The remaining README already reflects the desired features and usage as predicted by ChatGPT :)
Do not expect it to work yet!

## Features

- **Automatic Abbreviation Generation**:
LaTeXAbbrify scans your LaTeX workspace for acronym definitions and generates built-in [abbreviations](https://neovim.io/doc/user/map.html#abbreviation) for quick insertion in insert mode.
Both `acro`- and `acronym`-style definitions are supported, for example:

* `\DeclareAcronym{VoIP}{short=VoIP, long=Voice over IP}` when using the `acro` package.
* `\acrodef{VoIP}{Voice over IP}` when using the `acronym` package. 

- **Effortless Acronym Usage**:
Instead of typing out entire acronyms repeatedly (for example, `\ac{VoIP}`), simply use the generated abbreviations to save time and reduce typing errors.
That is, typing `VoIP` in insert mode is automatically expanded to `\ac{VoIP}` according to the Neovim expanding rules for abbreviations.

## Installation using [Lazy](https://github.com/folke/lazy.nvim)

```vim
{
    'wyv3rn/latex-abbrify',
    config = function()
        require('latex-abbrify').setup()
    end
}
```

## Usage

1. Open a LaTeX document in Neovim.
2. LaTeXAbbrify will automatically detect acronym definitions such as in your workspace.
3. While in insert mode, type the acronym (e.g., `VoIP`), and the built-in abbreviation mechanism will replace it with the corresponding `\ac{VoIP}`.
4. Enjoy efficient and consistent acronym usage in your LaTeX documents!

## Configuration

LaTeXAbbrify is not configurable at the moment.

## Issues and Contributions

If you encounter any issues or have suggestions for improvement, feel free to open an issue on the GitHub repository.
Contributions are welcome!

## License

This plugin is licensed under the [MIT License](https://opensource.org/licenses/MIT).
