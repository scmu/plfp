---
title: 工具
---

# The Glasgow Haskell Compiler

本課程使用 [Haskell](https://www.haskell.org/) 語言為教學工具。目前最被廣泛使用的 Haskell 實作是 Glasgow Haskell Compiler (GHC), 包含編譯器以及有互動介面的解譯器。

## 安裝

目前[官方推薦的方式](https://www.haskell.org/downloads/)是經由 [GHCup](https://www.haskell.org/ghcup/) 安裝 GHC, [cabal-install](https://cabal.readthedocs.io/) (Haskell 的套件安裝程式）, 以及 [haskell-language-server](https://github.com/haskell/haskell-language-server) (HLS, 配合編輯器以及 IDE 使用的支援工具)。

請參照 [GHCup](https://www.haskell.org/ghcup/) 的指示安裝。下指令後，會進入一個選單可選擇要裝哪些項目的選單。除預設的 GHC 與 cabal 等等之外，建議可裝 HLS。除非預備要使用 Haskell 開發大軟體，stack 可暫時不用。系統會抓適合的 GHC 來安裝。

安裝程式會幫忙改系統路徑。之後可能會需要開一個新的 shell/視窗。如在新開的 shell 之中下指令 `ghci`, 能看到 GHC 的提示符號，就是安裝成功了。

## GHCi 命令

安裝完畢後，從命令列下指令 ghci 即可進入 Glasgow Haskell Compiler 的互動介面。

常用指令如下。各指令都可只打第一個字母。如 :load 可簡寫為 :l。課堂上用到的指令包括 :load (載入檔案）, :reload （重新載入檔案）, :type <expr> （顯示 expr 的型別）等等。

    <statement>                 evaluate/run <statement>
    :                           repeat last command
    :{\n ..lines.. \n:}\n       multiline command
    :add [*]<module> ...        add module(s) to the current target set
    :browse[!] [[*]<mod>]       display the names defined by module <mod>
                               (!: more details; *: all top-level names)
    :cd <dir>                   change directory to <dir>
    :cmd <expr>                 run the commands returned by <expr>::IO String
    :ctags[!] [<file>]          create tags file for Vi (default: "tags")
                               (!: use regex instead of line number)
    :def <cmd> <expr>           define command :<cmd> (later defined command has
                               precedence, ::<cmd> is always a builtin command)
    :edit <file>                edit file
    :edit                       edit last module
    :etags [<file>]             create tags file for Emacs  (default: "TAGS")
    :help, :?                   display this list of commands
    :info [<name> ...]          display information about the given names
    :issafe [<mod>]             display safe haskell information of module <mod>
    :kind <type>                show the kind of <type>
    :load [*]<module> ...       load module(s) and their dependents
    :main [<arguments> ...]     run the main function with the given arguments
    :module [+/-] [*]<mod> ...  set the context for expression evaluation
    :quit                       exit GHCi
    :reload                     reload the current module set
    :run function [<arguments> ...] run the function with the given arguments
    :script <filename>          run the script <filename>
    :type <expr>                show the type of <expr>
    :undef <cmd>                undefine user-defined command :<cmd>
    :!<command>                 run the shell command <command>

# 與 GHC 搭配之編輯器

你可用任何習慣的文字編輯器，但須把程式存為副檔名 ".hs" 的檔案。（有些編輯器會在使用者不知情的情況下將檔名存為 ".hs.txt"。）

Windows 使用者不建議使用 NotePad, 因為該程式不認得 UNIX 的換行符號。其他可能選項包括：

  * [Atom](https://atom.io/) (Mac OS X, Windows, UNIX), 或其後續計畫 [Pulsar](https://pulsar-edit.dev/). 有 Haskell mode 可安裝。
  * [VS Code](https://code.visualstudio.com/) (Mac OS X, Windows, UNIX). 有 Haskell extension 可用。
  * [Emacs](http://www.gnu.org/s/emacs/) (Mac OS X, UNIX): 一個歷史悠久，非常強大的編輯器。
    * 有 [Haskell mode](http://www.haskell.org/haskellwiki/Haskell_mode_for_Emacs) 可安裝。
    * Mac OS 使用者除了上述的 offical 版本外，也可選擇 [Aquamacs](http://aquamacs.org/).
  * [NotePad++](http://notepad-plus-plus.org/) (Windows): an editor released under GPL license.
  * [Vim](https://vim.sourceforge.io/) (Mac OS X, UNIX).
  * [Sublime Text](https://www.sublimetext.com/) (Mac OS X, Windows, Linux).
  * [Eclipse FP](http://eclipsefp.github.com/) (cross platform): an Eclipse plug-in for Haskell that supports graphical debugging of modules, autocompletion, integration with GHC, etc.

# Agda

本課程後半可能使用 [Agda](https://wiki.portal.chalmers.se/agda/pmwiki.php), 一個具有依值型別 (dependent type) 的函數語言。

Agda 使用者需透過編輯器與後端對話。目前官方支援的編輯器是 [Emacs](http://www.gnu.org/s/emacs/), 但由台灣 programmer 開發的 VS Code [Agda extension](https://marketplace.visualstudio.com/items?itemName=banacorn.agda-mode)也很成熟，可以試用。

## Mac OS 與 Linux 安裝

Mac OS 與 Linux 使用者建議用 [homebrew](https://brew.sh/) 安裝。

1. 先安裝 homebrew. 請到 [homebrew 網頁](https://brew.sh/)。
2. 打開 Terminal. 將上述網頁的指令 copy & paste 到 shell中，安裝即開始。依照螢幕上的指令操作。
3. 用 homebrew 安裝 Agda. 在 Terminal 中下指令：
`brew install agda`
就會開始安裝。會需要一段時間。

3. 之後去 VS Code 之中安裝 extension [agda-mode](https://marketplace.visualstudio.com/items?itemName=banacorn.agda-mode).

安裝好後，開一個新檔案，將[這頁](https://agda.readthedocs.io/en/latest/getting-started/hello-world.html)的範例程式 copy and paste 到檔案中。注意 hello 前面需有空格。將檔名存成 `hello.agda`.然後按 Ctrl-C Ctrl-L （按住 Ctrl, 然後按 c, 再按 l）。如果文字出現有顏色的 highlight, 應該就是安裝成功了。

## Windows 安裝

建議的方法是安裝 [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/zh-tw/windows/wsl/about)。這相當於在 Windows 中執行一個 Linux. 然後把 Agda 裝在裡面。

請參考以下指南 --- 由助教林小喬撰寫：
https://hackmd.io/@chiaoooo/ByJJoJ5HT

## 常用指令

以下為 VS Code 或 emacs 的 agda-mode 常用之指令。更完整的列表可參考 [agda-mode 之說明](https://marketplace.visualstudio.com/items?itemName=banacorn.agda-mode).

`C-c` 表示「按住 `Ctrl` 鍵，按 `c` 鍵，然後一起放開」。 `C-c C-l` 可以合併為「按住 `Ctrl` 鍵，按 `c` 鍵，放開 `c` 鍵，按 `l` 鍵，最後一起放開」。

任何時候都可下的指令：

* load:	`C-c C-l` （注意 `l` 為小寫 `L`）
* quit and restart: `C-x C-r`

游標在「洞」中時可下的指令：

* refine:	`C-c C-r`
* case split: `C-c C-c`
* auto: `C-c C-a`
* goal type and context: `C-c C-,`
* goal type and context (instantiated): `C-u C-,` (在 emacs 中是 `C-u C-c C-,`)
* goal type and context (normalized): `C-y C-,` (在 emacs 中是 `C-u C-u C-c C-,`)
