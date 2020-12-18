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
; (global-set-key "\C-h" 'delete-backward-char)
(define-key key-translation-map [?\C-h] [?\C-?])
(define-key global-map [?¥] [?\\])
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "C-x C-M-f") 'project-find-file)
(global-set-key (kbd "C-c t") 'recentf-open-files)

; バックアップファイルをつくらない
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq next-line-add-newlines nil)

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

(ivy-mode 1)

;;; Input Method Configuration

;; SKK

(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)

(when (require 'skk nil t)
  (setq skk-server-host "localhost")
  (setq skk-server-portnum 55100)
  (setq skk-share-private-jisyo t)
  (setq skk-large-jisyo "~/.skk/SKK-JISYO.L")
  (setq skk-show-icon t)
  (setq skk-show-annotation t)
  (setq default-input-method "japanese-skk")

  (setq skk-jisyo (cons "~/.skk-jisyo" 'utf-8))
)

(global-company-mode t)

(global-set-key (kbd "C-M-i") 'company-complete)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

(with-eval-after-load 'php-mode
  (define-key php-mode-map (kbd "C-M-i") 'company-phpactor))

(setq frame-title-format "%f")
(setq text-mode-hook 'turn-off-auto-fill)

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(define-key global-map [?¥] [?\\])  ;; ¥の代わりにバックスラッシュを入力する


;; pyim
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
; (setq default-input-method "pyim")
