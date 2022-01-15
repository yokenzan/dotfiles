;; -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; My init.el.
;;
;; based on
;;     - https://emacs-jp.github.io/tips/emacs-in-2020
;;     - https://uwabami.github.io/cc-env/Emacs.html
;;     - https://uwabami.junkhub.org/log/20111213.html#p01

;;; Code:

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; ここにいっぱい設定を書く

;; cus-edit.c

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))


;; cus-start.c

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))
  :bind (("M-ESC ESC" . c/redraw-frame))
  :custom '((user-full-name . "Onuki Yosuke")
            (user-mail-address . "31175068+yokenzan@users.noreply.github.com")
            (user-login-name . "yokenzan")
            (create-lockfiles . nil)
            (debug-on-error . t)
            (init-file-debug . t)
            (frame-resize-pixelwise . t)
            (enable-recursive-minibuffers . t)
            (history-length . 1000)
            (history-delete-duplicates . t)
            (scroll-preserve-screen-position . t)
            (scroll-conservatively . 100)
            (mouse-wheel-scroll-amount . '(1 ((control) . 5)))
            (ring-bell-function . 'ignore)
            (text-quoting-style . 'straight)
            (truncate-lines . t)
            ;; (use-dialog-box . nil)
            ;; (use-file-dialog . nil)
            ;; (menu-bar-mode . t)
            (tool-bar-mode . nil)
            (scroll-bar-mode . nil)
            (indent-tabs-mode . nil))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (keyboard-translate ?\C-h ?\C-?))


;; autorevert

;; Emacsの外でファイルが書き変わったときに自動的に読み直すマイナーモードです。 もちろん、Emacsで編集している場合は外の変更で上書きされることはありません。

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 1))
  :global-minor-mode global-auto-revert-mode)


;; cc-mode

(leaf cc-mode
  :doc "major mode for editing C and similar languages"
  :tag "builtin"
  :defvar (c-basic-offset)
  :bind (c-mode-base-map
         ("C-c c" . compile))
  :mode-hook
  (c-mode-hook . ((c-set-style "bsd")
                  (setq c-basic-offset 4)))
  (c++-mode-hook . ((c-set-style "bsd")
                    (setq c-basic-offset 4))))

;; delsel

;; 選択している状態で入力したときに、regionを削除して挿入するマイナーモードです。 おそらくこの挙動のほうが現代人の意図に合っていると思います。

(leaf delsel
  :doc "delete selection if you insert"
  :tag "builtin"
  :global-minor-mode delete-selection-mode)


;; paren

(leaf paren
  :doc "highlight matching paren"
  :tag "builtin"
  :custom ((show-paren-delay . 0.1))
  :global-minor-mode show-paren-mode)


;; simple

(leaf simple
  :doc "basic editing commands for Emacs"
  :tag "builtin" "internal"
  :custom ((kill-ring-max . 100)
           (kill-read-only-ok . t)
           (kill-whole-line . t)
           (eval-expression-print-length . nil)
           (eval-expression-print-level . nil))
  :hook
  (emacs-startup-hook . transient-mark-mode))


;; files

(leaf files
  :doc "file input and output commands for Emacs"
  :tag "builtin"
  :custom `((auto-save-timeout . 15)
            (auto-save-interval . 60)
            (auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
            (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
                                        (,tramp-file-name-regexp . nil)))
            (version-control . t)
            (delete-old-versions . t)))


;; startup

(leaf startup
  :doc "process Emacs shell arguments"
  :tag "builtin" "internal"
  :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-"))))


;; ivy

(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :blackout t
  :leaf-defer nil
  :custom ((ivy-initial-inputs-alist . nil)
           (ivy-use-selectable-prompt . t))
  :global-minor-mode t
  :config
  (leaf swiper
    :doc "Isearch with an overview. Oh, man!"
    :req "emacs-24.5" "ivy-0.13.0"
    :tag "matching" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :bind (("C-s" . swiper)))

  (leaf counsel
    :doc "Various completion functions using Ivy"
    :req "emacs-24.5" "swiper-0.13.0"
    :tag "tools" "matching" "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :blackout t
    :bind (("C-S-s" . counsel-imenu)
          ("C-x C-r" . counsel-recentf))
    :custom `((counsel-yank-pop-separator . "\n----------\n")
              (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group)))
    :global-minor-mode t))

(leaf prescient
  :doc "Better sorting and filtering"
  :req "emacs-25.1"
  :tag "extenssions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :custom ((prescient-aggressive-file-save . t))
  :global-minor-mode prescient-persist-mode)

(leaf ivy-prescient
  :doc "prescient.el + Ivy"
  :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :after prescient ivy
  :custom ((ivy-prescient-retain-classic-highlighting . t))
  :global-minor-mode t)


(leaf company
  :doc "Modular text completion framework"
  :req "emacs-24.3"
  :tag "matching" "convenience" "abbrev" "emacs>=24.3"
  :url "http://company-mode.github.io/"
  :emacs>= 24.3
  :ensure t
  :blackout t
  :leaf-defer nil
  :bind ((company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("<tab>" . company-complete-selection))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom ((company-idle-delay . 0)
           (company-minimum-prefix-length . 1)
           (company-transformers . '(company-sort-by-occurrence)))
  :global-minor-mode global-company-mode)

(leaf company-c-headers
  :doc "Company mode backend for C/C++ header files"
  :req "emacs-24.1" "company-0.8"
  :tag "company" "development" "emacs>=24.1"
  :added "2020-03-25"
  :emacs>= 24.1
  :ensure t
  :after company
  :defvar company-backends
  :config
  (add-to-list 'company-backends 'company-c-headers))

;;
;;
;;

(leaf recentf
  :ensure t
  :bind (
        ("C-c t" . recentf-open-files)
         )
  :custom ((recentf-max-saved-items . 2000)
           (recentf-auto-cleanup . 'never))
  :global-minor-mode recentf-mode)


;; (leaf find-file-in-project
;;   :ensure t
;;   :bind ("C-x C-M-f" . project-find-file))


(leaf projectile
  :ensure t)


(leaf kotlin-mode
  :ensure t)


(leaf atomic-chrome
  :ensure t
  :custom (atomic-chrome-start-server))


(leaf linum
  :ensure t
  :global-minor-mode global-linum-mode)


(leaf magit
  :ensure t)


(leaf markdown-mode
  :ensure t
  :setq (initial-major-mode . 'markdown-mode) ;; set markdown-mode as major mode when opening scratch buffer
        (initial-scratch-message . nil)       ;; empty scratch buffer
        )


(leaf hl-line
  :ensure t
  :hook (emacs-startup-hook . global-hl-line-mode)
  )


(leaf paren
  :ensure t
  :custom ((show-paren-style . 'mixed))
  :hook (emacs-startup-hook . show-paren-mode)
  )


(leaf *color-themes
  :config
  (leaf gruvbox-theme
    :ensure t)

  (leaf moe-theme
    :ensure t)

  (leaf paper-theme
    :ensure t)

  (leaf avk-emacs-themes
    :ensure t)

  (leaf material-theme
    :ensure t)

  (leaf afternoon-theme
    :ensure t)

  (leaf dracula-theme
    :ensure t)

  (leaf flatui-theme
    :ensure t)

  (leaf molokai-theme
    :ensure t))


(leaf *local-variables
  :setq (inhibit-startup-message . t)     ;; Don't show startup page when launch Emacs
        (scroll-conservatively . 5)       ;; 画面外にカーソルが行ったとき、スクロールする行数
        (set-mark-command-repeat-pop . t) ;; http://emacs.rubikitch.com/sd1509-safeguard-undo-redo/
        (scroll-margin . 4)
  :custom (display-time-mode . t)
  :global-minor-mode column-number-mode)


(leaf *date-time-config
  :setq (display-time-day-and-date . t)  ;; 曜日・月・日
        (display-time-24hr-format . t)   ;; 24時間表示
  :global-minor-mode display-time-mode)


;; Font Configuration

;; config only when running on GUI
(when window-system (progn
                      (create-fontset-from-ascii-font "Sarasa Fixed Slab J-12:weight=normal:slant=normal" nil "myfontset")

                      (set-fontset-font "fontset-myfontset" 'japanese-jisx0213.2004-1 "Sarasa Fixed Slab J-12=normal:slant=normal"  nil 'append)
                      (set-fontset-font "fontset-myfontset" 'big5-hkscs               "Sarasa Fixed Slab J-12=normal:slant=normal" nil 'append)
                      (set-fontset-font "fontset-myfontset" 'chinese-gb2312           "Sarasa Fixed Slab J-12=normal:slant=normal" nil 'append)
                      (set-fontset-font "fontset-myfontset" 'japanese-jisx0208        "Sarasa Fixed Slab J-12=normal:slant=normal"  nil 'append)
                      (set-fontset-font "fontset-myfontset" 'japanese-jisx0212        "Sarasa Fixed Slab J-12=normal:slant=normal"  nil 'append)
                      (set-fontset-font "fontset-myfontset" 'latin-jisx0201           "Sarasa Fixed Slab J-12=normal:slant=normal"  nil 'append)
                      (set-fontset-font "fontset-myfontset" 'japanese-jisx0213.2004-1 "Sarasa Fixed Slab J-12=normal:slant=normal"  nil 'append)
                      (set-fontset-font "fontset-myfontset" 'japanese-jisx0213-1      "Sarasa Fixed Slab J-12=normal:slant=normal"  nil 'append)
                      (set-fontset-font "fontset-myfontset" 'japanese-jisx0208-1978   "Sarasa Fixed Slab J-12=normal:slant=normal"  nil 'append)

                      (add-to-list 'default-frame-alist '(font . "fontset-myfontset"))))


(provide 'init)

(load-theme 'flatui t)

;; Undelivered Configuration

;;; ;;; Org Mode
;;; 
;;; ;; The following lines are always needed.  Choose your own keys.
;;; (global-set-key "\C-cl" 'org-store-link)
;;; (global-set-key "\C-ca" 'org-agenda)
;;; (global-set-key "\C-cc" 'org-capture)
;;; (global-set-key "\C-cb" 'org-switchb)
;;; 
;;; 
;;; (setq org-directory "~/winhome/OneDrive/org")
;;; (setq org-default-notes-file "notes.org")
;;; 
;;; ;; Org-capture
;;; 
;;; ; Org-captureを呼び出すキーシーケンス
;;; (define-key global-map "\C-cc" 'org-capture)
;;; ; Org-captureのテンプレート（メニュー）の設定
;;; (setq org-capture-templates
;;;       '(("n" "Note" entry (file+headline "~/winhome/OneDrive/org/notes.org" "Notes")
;;;          "* %?\nEntered on %U\n %i\n %a")
;;;         ))
;;; 
;;; 
;;; ;; メモをC-M-^一発で見るための設定
;;; ;; https://qiita.com/takaxp/items/0b717ad1d0488b74429d から拝借
;;; (defun show-org-buffer (file)
;;;   "Show an org-file FILE on the current buffer."
;;;   (interactive)
;;;   (if (get-buffer file)
;;;       (let ((buffer (get-buffer file)))
;;;         (switch-to-buffer buffer)
;;;         (message "%s" file))
;;;     (find-file (concat "~/winhome/OneDrive/org/" file))))
;;; (global-set-key (kbd "C-M-^") '(lambda () (interactive)
;;;                                  (show-org-buffer "notes.org")))
;;; 
;;; 
;;; 
;;; 
;;; ;; FlyCheck
;;; 
;;; ;; PHP
;;; (defun my-php-mode-hook ()
;;;    "My PHP-mode hook."
;;;    ;(require 'flycheck-phpstan)
;;;    ;(flycheck-mode t)
;;;    ;(flycheck-select-checker 'phpstan))
;;; )
;;; (add-hook 'php-mode-hook 'my-php-mode-hook)
;;; 
;;; 
;;; ; (global-flycheck-mode)
;;; ; (setq flycheck-indication-mode 'left-fringe)
;;; ; (setq flycheck-check-syntax-automatically '(mode-enabled save))
;;; 
;;; 
;;; ;; (define-key global-map [?¥] [?\\])  ;; ¥の代わりにバックスラッシュを入力する
;;; 
;;; ;; カーソル位置の復旧で、
;;; ;; C-u C-SPC C-u C-SPC C-u C-SPC .. と押す必要があるのを、
;;; ;; C-u C-SPC C-SPC C-SPC .. ですむようにする。
;;; ;; http://emacs.rubikitch.com/sd1509-safeguard-undo-redo/
;;; (setq set-mark-command-repeat-pop t)
;;; 
;;; 
;;; (setq frame-title-format "%f")
;;; (setq text-mode-hook 'turn-off-auto-fill)
;;; 
;;; (defun x-clipboard-copy ()
;;;   (interactive)
;;;   (when (region-active-p)
;;;     (shell-command-on-region (region-beginning) (region-end) "clip.exe" nil nil)))
;;; 





;; End:

;;; init.el ends here
