# kvimrc
## Installation
1. Install related tools
```
pip install pyflakes yapf compiledb
```
1. Install vimrc
```bash
git clone https://github.com/sykuang/kvimrc.git $HOME/.kvimrc;ln -s $HOME/.kvimrc/vimrc $HOME/.vimrc
```
## HotKey
1. `<leader>`
    - leader key is `;`
2. [Auto Format](https://github.com/Chiel92/vim-autoformat)
   - `,af` for Auto Format
3. [cscope](https://github.com/brookhong/cscope.vim)
   * `<leader>bs` :cs find s Current Word
   * `<leader>bg` :cs find g Current Word
   * `<leader>bc` :cs find c Current Word
   * `<leader>bt` :cs find t Current Word
   * `<leader>be` :cs find e Current Word
   * `<leader>bf` :cs find f Current Word
   * `<leader>bi` :cs find i Current Word
   * `<leader>bd` :cs find d Current Word
4. [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
    * `[count]<leader>cc` **|NERDComComment|**

    Comment out the current line or text selected in visual mode.

    * `[count]<leader>cn` **|NERDComNestedComment|**

    Same as <leader>cc but forces nesting.

    * `[count]<leader>c<space>` **|NERDComToggleComment|**

    Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.

    * `[count]<leader>cm` **|NERDComMinimalComment|**

    Comments the given lines using only one set of multipart delimiters.

    * `[count]<leader>ci` **|NERDComInvertComment|**

    Toggles the comment state of the selected line(s) individually.

    * `[count]<leader>cs` **|NERDComSexyComment|**

    Comments out the selected lines with a pretty block formatted layout.

    * `[count]<leader>cy` **|NERDComYankComment|**

    Same as <leader>cc except that the commented line(s) are yanked first.

    * `<leader>c$` **|NERDComEOLComment|**

    Comments the current line from the cursor to the end of line.

    * `<leader>cA` **|NERDComAppendComment|**

    Adds comment delimiters to the end of line and goes into insert mode between them.

    * **|NERDComInsertComment|**

    Adds comment delimiters at the current cursor position and inserts between. Disabled by default.

    * `<leader>ca` **|NERDComAltDelim|**

    Switches to the alternative set of delimiters.

    * `[count]<leader>cl`
    `[count]<leader>cb` **|NERDComAlignedComment|**

    Same as **|NERDComComment|** except that the delimiters are aligned down the left side (`<leader>cl`) or both sides (`<leader>cb`).

    * `[count]<leader>cu` **|NERDComUncommentLine|**

    Uncomments the selected line(s).
5. [spellcheck](https://github.com/vim-scripts/vimspell)
	* To enable spell check  
`shift + F7`
6. [Youcomplete](https://github.com/Valloric/YouCompleteMe)
    * Toggle youcomplete at runtime  
    `<leader>ly`

### Usage
For more usage, you can refer (https://github.com/fisadev/fisa-vim-config/blob/master/docs/features.rst)

Branch from :[fisa-vim-config](https://github.com/fisadev/fisa-vim-config)
