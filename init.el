;; Package Configuration
(require 'package)
(add-to-list 'package-archives '("melpa"     . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
(package-initialize)


;; Font Configuration
(create-fontset-from-ascii-font "Iosevka TermLig Curly Slab-11:weight=normal:slant=normal" nil "myfontset")
(set-fontset-font "fontset-myfontset" 'japanese-jisx0213.2004-1 "Sarasa Mono T J-11"  nil 'append)
(set-fontset-font "fontset-myfontset" 'big5-hkscs               "Sarasa Mono T TC-11" nil 'append)
(set-fontset-font "fontset-myfontset" 'chinese-gb2312           "Sarasa Mono T SC-11" nil 'append)
(add-to-list 'default-frame-alist '(font . "fontset-myfontset"))


;; Modify Default Key Maps
(define-key key-translation-map [?\C-h] [?\C-?])
(define-key global-map [?¥] [?\\])


;; File Loading

; (setq debug-on-error t)
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

(defun yokenzan/add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (unless (file-exists-p default-directory)
          (make-directory default-directory))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(yokenzan/add-to-load-path "elisp" "conf")


;; Modificaions or Settings Written by Emacs Automatically
(setq custom-file (locate-user-emacs-file "custom.el"))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)


(column-number-mode t)
(global-linum-mode t)
(show-paren-mode t)
(setq scroll-conservatively 1)
(setq scroll-margin 4)
(global-hl-line-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t)

;; Backup Files
(setq backup-directory-alist '((".*" . "~/.ehist")))

;; Define "quit" Command
(defalias 'quit 'kill-emacs)


(setq-default indent-tabs-mode nil)


;; Follow Symbolic Links When Opening Files
(setq vc-follow-symlinks t)


;; MRU
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)

;;; Input Method Configuration

;; SKK
(setq skk-server-host "localhost")
(setq skk-server-portnum 55100)
(setq skk-share-private-jisyo t)
(setq skk-large-jisyo "~/.skk/SKK-JISYO.L")
(setq skk-show-icon t)
(setq skk-show-annotation t)
; (setq default-input-method "japanese-skk")

;; pyim
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
; (setq default-input-method "pyim")
