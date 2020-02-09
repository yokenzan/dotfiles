;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Font Configuration
(create-fontset-from-ascii-font "Iosevka TermLig Curly Slab-12:weight=normal:slant=normal" nil "myfontset")
(set-fontset-font "fontset-myfontset" 'japanese-jisx0213.2004-1 "Sarasa Mono T J-12"  nil 'append)
(set-fontset-font "fontset-myfontset" 'big5-hkscs               "Sarasa Mono T TC-12" nil 'append)
(set-fontset-font "fontset-myfontset" 'chinese-gb2312           "Sarasa Mono T SC-12" nil 'append)
(add-to-list 'default-frame-alist '(font . "fontset-myfontset"))

;; Modify Default Key Maps
(define-key key-translation-map [?\C-h] [?\C-?])
