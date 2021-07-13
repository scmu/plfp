---
title: 工具
---

# The Glasgow Haskell Compiler

目前最被廣泛使用的 Haskell 實作是 [Glasgow Haskell Compiler (GHC)](http://www.haskell.org/ghc), 包含編譯器以及有互動介面的解譯器。

## 安裝

最簡單的方式是安裝 [Haskell Platform](http://hackage.haskell.org/platform/). 這是一整組包含許多 Haskell 相關工具的套件，其中也包含 GHC.

請至 [Haskell Platform](http://hackage.haskell.org/platform/) 首頁上選擇自己使用的作業系統後下載，並按照指示安裝。

Ubuntu Linux 使用者請勿使用 apt-get --- 如此會安裝到很舊的版本。請使用 Generic Linux 的安裝法。

## GHCi 命令

安裝完畢後，從命令列下指令 ghci 即可進入 Glasgow Haskell Compiler 的互動介面。Windows 使用者可執行 WinGHCi.

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

# 編輯器

你可用任何習慣的文字編輯器，但須把程式存為副檔名 ".hs" 的檔案。

Windows 使用者不建議使用 NotePad, 因為該程式不認得 UNIX 的換行符號。其他可能選項包括：

  * [NotePad++](http://notepad-plus-plus.org/) (Windows): an editor released under GPL license.
  * [Vim](https://vim.sourceforge.io/) (Mac OS X, UNIX).
  * [Atom](https://atom.io/) (Mac OS X, Windows, UNIX).
  * [Emacs](http://www.gnu.org/s/emacs/) (Mac OS X, UNIX): a very powerful editor with customised modes for many programming languages.
    * There is a [Haskell mode](http://www.haskell.org/haskellwiki/Haskell_mode_for_Emacs) for Emacs that supports syntax highlighting, inferior GHCi mode, etc.
    * OS X users may want to try [Aquamacs](http://aquamacs.org/), an OS X port that looks more native.
  * [Sublime Text](https://www.sublimetext.com/) (Mac OS X, Windows, Linux).
  * [Eclipse FP](http://eclipsefp.github.com/) (cross platform): an Eclipse plug-in for Haskell that supports graphical debugging of modules, autocompletion, integration with GHC, etc.
