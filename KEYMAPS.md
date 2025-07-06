# Neovim Keymaps

## Core Keymaps

Please Note that <leader> here means space

### Search Navigation

- `n` - Next search result (centered)
- `N` - Previous search result (centered)
- `n` (visual/operator) - Next search result
- `N` (visual/operator) - Previous search result

### Indentation

- `<` (visual) - Decrease indentation (maintain selection)
- `>` (visual) - Increase indentation (maintain selection)

### Comments

- `gco` - Add comment below current line
- `gcO` - Add comment above current line
- `gct` - Add TODO comment below current line
- `gcT` - Add TODO comment above current line

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

- `<leader>bn` - Move to next buffer
- `<leader>bp` - Move to previous buffer
- `<leader><BS>` - Close buffer
- `<leader>bC` - Close all buffers

### Visual Mode Movement

- `J` (visual) - Move selections down
- `K` (visual) - Move selections up

## Plugin Keymaps

### Yanky (Yank History)

- `p` - Paste after cursor
- `P` - Paste before cursor
- `<C-n>` - Cycle to next yanked item
- `<C-p>` - Cycle to previous yanked item
- `y` - Yank
- `<leader>y` - Show yank history

### Treesitter Context

- `<leader>ut` - Toggle treesitter context

### Substitute

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

- `<leader>x` - Lists (location, quickfix)
- `<leader>c` - Code actions (diagnostics)
- `<leader>u` - UI toggles (inlay hints, treesitter context)
- `<leader>g` - Git operations
- `<leader>b` - Buffer operations
- `<leader>r` - Substitute range operations
- `<leader><leader>` - Swap buffer operations
- `<leader>p` - Split actions
- `<leader>h` - Harpoon operations

### Special Keys

- `<localleader>` - Local leader for window resize operations
- `<C-*>` - Control key combinations for navigation and quick actions
