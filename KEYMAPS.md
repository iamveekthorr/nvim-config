# Neovim Keymaps

## Core Keymaps

Please Note that <leader> here means space and <localleader> means comma

### Search Navigation

- `n` - Next search result (centered)
- `N` - Previous search result (centered)

### Indentation

- `<` (visual) - Decrease indentation (maintain selection)
- `>` (visual) - Increase indentation (maintain selection)

### Comments

- `gc` - Comment toggle (normal/visual)
- `<leader>/` - Comment line/selection
- `gco` - Add comment below current line
- `gcO` - Add comment above current line
- `gct` - Add TODO comment below current line
- `gcT` - Add TODO comment above current line

### Code Folding (VSCode-like)

- `<leader>zc` - Close fold under cursor
- `<leader>zo` - Open fold under cursor
- `<leader>za` - Toggle fold under cursor
- `<leader>zC` - Close all folds under cursor recursively
- `<leader>zO` - Open all folds under cursor recursively
- `<leader>zM` - Close all folds in buffer
- `<leader>zR` - Open all folds in buffer
- `<leader>zm` - Fold more (increase fold level)
- `<leader>zr` - Fold less (decrease fold level)

### Lists

- `<leader>xl` - Toggle location list
- `<leader>xq` - Toggle quickfix list

### Diagnostics

- `<leader>cd` - Show line diagnostics
- `]e` - Next error
- `[e` - Previous error
- `]w` - Next warning
- `[w` - Previous warning
- `<leader>uh` - Toggle inlay hints

### Git (via Lazygit)

- `<leader>gg` - Open Lazygit (root dir)
- `<leader>gf` - Git current file history
- `<leader>gl` - Git log (root dir)
- `<leader>gL` - Git log (current dir)

### Navigation & Movement

- `J` - Join line below to current line (preserve cursor position)
- `<C-d>` - Jump down and center
- `<C-u>` - Jump up and center
- `<C-q>` - Quit nvim violently
- `<leader>w` - Save buffer
- `|` - Vertical split
- `\` - Horizontal split

### Buffer Management

- `<leader><BS>` - Close buffer
- `<leader>bC` - Close all buffers

### Visual Mode Movement & Text Wrapping

- `J` (visual) - Move selections down
- `K` (visual) - Move selections up
- `<leader>p` (visual) - Wrap selection in parentheses
- `<leader>b` (visual) - Wrap selection in brackets
- `<leader>B` (visual) - Wrap selection in braces

## Plugin Keymaps

### Blink (Completion)

- `<C-p>` (insert) - Show completion menu, show/hide documentation
- `<C-c>` (insert) - Cancel completion
- `<Up>` (insert) - Select previous completion item
- `<Down>` (insert) - Select next completion item
- `<C-b>` (insert) - Scroll documentation up
- `<C-f>` (insert) - Scroll documentation down
- `<C-k>` (insert) - Show/hide signature help

### Yanky (Yank History)

- `p` - Paste after cursor
- `P` - Paste before cursor
- `<C-n>` - Cycle to next yanked item
- `<C-p>` - Cycle to previous yanked item
- `y` - Yank
- `<leader>y` - Show yank history

### Snacks (File Explorer & Picker)

#### File Operations

- `<leader>e` - Open explorer
- `<leader>fr` - Recent files (cwd)
- `<leader>ff` - Find files (Root Dir)
- `<leader>fF` - Find files (cwd) with hidden/ignored
- `<leader>fR` - Recent files (All)

#### Search Operations

- `<leader>s<cr>` - Resume picker
- `<leader>sg` - Grep (Root Dir)
- `<leader>sG` - Grep (cwd) with hidden/ignored

#### Picker Internal (within picker interface)

- `<C-d>` (insert/normal) - Preview scroll down
- `<C-u>` (insert/normal) - Preview scroll up

### Treesitter Context

- `<leader>ut` - Toggle treesitter context

### Substitute

#### Basic Substitution

- `s` - Substitute selection with register content
- `ss` - Substitute line with register content
- `S` - Substitute until end of line with register content
- `s` (visual) - Substitute selection with register content

#### Substitute Range

- `<leader>r` - Substitute selection and destination with input
- `<leader>rs` - Substitute word under cursor and destination with input
- `<leader>r` (visual) - Substitute selection and destination with input

#### Substitute Exchange

- `sx` - Exchange operator
- `sxx` - Exchange line
- `X` (visual) - Exchange visual selection
- `sxc` - Cancel exchange

### Mini.surround

- `gsa` - Add surround
- `gsd` - Delete surround
- `gsr` - Replace surround

### Trouble (Diagnostics)

- `<leader>ce` - LSP references/definitions/... (Trouble)
- `<leader>xx` - Buffer Diagnostics (Trouble)
- `<leader>xX` - Diagnostics (Trouble)

### Other.nvim (File Switching)

- `<leader>oo` - Show other menu
- `<leader>om` - Go to other module
- `<leader>os` - Go to other service
- `<leader>oa` - Go to other schema
- `<leader>oc` - Go to other controller
- `<leader>ot` - Go to other type
- `<leader>ou` - Go to other util

### Smart Splits

#### Resize Splits

- `<localleader>h` - Resize left
- `<localleader>j` - Resize down
- `<localleader>k` - Resize up
- `<localleader>l` - Resize right

#### Move Cursor Between Splits

- `<C-h>` - Move cursor left
- `<C-j>` - Move cursor down
- `<C-k>` - Move cursor up
- `<C-l>` - Move cursor right

#### Swap Buffers

- `<leader><leader>h` - Swap buffer left
- `<leader><leader>j` - Swap buffer down
- `<leader><leader>k` - Swap buffer up
- `<leader><leader>l` - Swap buffer right

#### Split Actions

- `<leader>pm` - Toggle maximize current split
- `<leader>pc` - Close current split

### Harpoon

- `<leader>ha` - Add file to harpoon
- `<leader>he` - Show harpoon ui
- `<leader>hh` - Navigate to first harpoon file
- `<leader>hj` - Navigate to second harpoon file
- `<leader>hk` - Navigate to third harpoon file
- `<leader>hl` - Navigate to fourth harpoon file
- `<leader>hn` - Navigate to next harpoon file
- `<leader>hp` - Navigate to previous harpoon file

## Key Combinations

### Leader Key Groups

- `<leader>z` - Code folding operations
- `<leader>x` - Lists (location, quickfix, diagnostics)
- `<leader>c` - Code actions (diagnostics, LSP)
- `<leader>u` - UI toggles (inlay hints, treesitter context)
- `<leader>g` - Git operations
- `<leader>b` - Buffer operations
- `<leader>f` - File operations (find, recent)
- `<leader>s` - Search operations (grep, resume)
- `<leader>r` - Substitute range operations
- `<leader>o` - Other.nvim file switching
- `<leader><leader>` - Swap buffer operations
- `<leader>p` - Split actions & visual text wrapping
- `<leader>h` - Harpoon operations
- `<leader>y` - Yank history
- `<leader>e` - File explorer
- `<leader>/` - Comments

### Special Keys

- `<localleader>` (comma) - Local leader for window resize operations
- `<C-*>` - Control key combinations for navigation and quick actions
- `g*` - Vim's "go" commands (surround, comments)
- `s*` - Substitute operations
- `]` / `[` - Next/previous navigation (errors, warnings)

### Mode-Specific Keymaps

#### Insert Mode

- `<C-p>`, `<C-c>`, `<Up>`, `<Down>`, `<C-b>`, `<C-f>`, `<C-k>` - Completion (Blink)

#### Visual Mode

- `<`, `>` - Indentation
- `J`, `K` - Move selections
- `<leader>p`, `<leader>b`, `<leader>B` - Wrap in parentheses/brackets/braces
- `s`, `X` - Substitute operations

#### Normal Mode

- Most keymaps are in normal mode by default

## Disabled Features

Some plugins have disabled keymaps to avoid conflicts:

- Flash navigation (`s`, `S`, `R`)
- Some default LazyVim keymaps (`<leader>E`, `<leader><space>`, etc.)
- Buffer line (plugin disabled)
- Auto pairs (plugin disabled)
