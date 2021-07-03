;; Package Configuration

(require 'package)
(add-to-list 'package-archives '("melpa"     . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
(package-initialize)


;; Modify Default Key Maps

(global-set-key "\C-h" 'delete-backward-char)
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "C-x C-M-f") 'project-find-file)
(global-set-key (kbd "C-c t") 'recentf-open-files)


;; Backup Files

; (setq make-backup-files nil)
(setq backup-directory-alist '((".*" . "~/.ehist")))
; (setq auto-save-default nil)
; (setq next-line-add-newlines nil)
(setq create-lockfiles nil)


;; Define "quit" Command

(defalias 'quit 'kill-emacs)


;; TAB SPACE Config

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)


;; File Loading

; Follow Symbolic Links When Opening Files
(setq vc-follow-symlinks t)
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


;; Line Number Configurations

(column-number-mode t)
(global-linum-mode t)
(setq linum-format "%4d ")
(show-paren-mode t)
(setq scroll-conservatively 1)
(setq scroll-margin 4)


;; highlight cursor line

(global-hl-line-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)


;;

(setq inhibit-startup-message t)
(setq initial-major-mode 'markdown-mode)
(setq initial-scratch-message nil)

;; MRU

(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)


(ivy-mode 1)


;;; Input Method Configuration

;; SKK

; (global-set-key "\C-x\C-j" 'skk-mode)
; (global-set-key "\C-xj" 'skk-auto-fill-mode)
;
; (when (require 'skk nil t)
;   (setq skk-server-host "localhost")
;   (setq skk-server-portnum 55100)
;   (setq skk-share-private-jisyo t)
;   (setq skk-large-jisyo "~/.skk/SKK-JISYO.L")
;   (setq skk-show-icon t)
;   (setq skk-show-annotation t)
;   (setq default-input-method "japanese-skk")
;
;   (setq skk-jisyo (cons "~/.skk-jisyo" 'utf-8))
; )


;; PYIM

;; (require 'pyim)
;; (require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
;; (pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
;; (setq default-input-method "pyim")
;; 
;; 
;; (defun my-converter (string)
;;   (mapconcat
;;    #'(lambda (x)
;;        (let ((str (cdr (assoc (char-to-string x) mytable))))
;;          (or (when (and str (stringp str))
;;                (car (split-string str " ")))
;;              (char-to-string x))))
;;    string ""))
;; 
;; (setq pyim-magic-converter #'my-converter)


;; Company

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


;;; Org Mode

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)


(setq org-directory "~/winhome/GoogleDrive/org")
(setq org-default-notes-file "notes.org")

;; Org-capture

; Org-captureを呼び出すキーシーケンス
(define-key global-map "\C-cc" 'org-capture)
; Org-captureのテンプレート（メニュー）の設定
(setq org-capture-templates
      '(("n" "Note" entry (file+headline "~/winhome/GoogleDrive/org/notes.org" "Notes")
         "* %?\nEntered on %U\n %i\n %a")
        ))


;; FlyCheck

;; PHP
(defun my-php-mode-hook ()
   "My PHP-mode hook."
   ;(require 'flycheck-phpstan)
   ;(flycheck-mode t)
   ;(flycheck-select-checker 'phpstan))
)
(add-hook 'php-mode-hook 'my-php-mode-hook)


; (global-flycheck-mode)
; (setq flycheck-indication-mode 'left-fringe)
; (setq flycheck-check-syntax-automatically '(mode-enabled save))


;; (define-key global-map [?¥] [?\\])  ;; ¥の代わりにバックスラッシュを入力する

;; カーソル位置の復旧で、
;; C-u C-SPC C-u C-SPC C-u C-SPC .. と押す必要があるのを、
;; C-u C-SPC C-SPC C-SPC .. ですむようにする。
;; http://emacs.rubikitch.com/sd1509-safeguard-undo-redo/
(setq set-mark-command-repeat-pop t)

(setq display-time-day-and-date t)  ;; 曜日・月・日
(setq display-time-24hr-format t)   ;; 24時表示
(display-time-mode t)


(setq frame-title-format "%f")
(setq text-mode-hook 'turn-off-auto-fill)

(defun x-clipboard-copy ()
  (interactive)
  (when (region-active-p)
    (shell-command-on-region (region-beginning) (region-end) "xsel -bi" nil nil)))


;; Font Configuration
;
; (create-fontset-from-ascii-font "Iosevka TermLig Curly Slab-11:weight=normal:slant=normal" nil "myfontset")
; (set-fontset-font "fontset-myfontset" 'japanese-jisx0213.2004-1 "Sarasa Mono T J-11"  nil 'append)
; (set-fontset-font "fontset-myfontset" 'big5-hkscs               "Sarasa Mono T TC-11" nil 'append)
; (set-fontset-font "fontset-myfontset" 'chinese-gb2312           "Sarasa Mono T SC-11" nil 'append)
; (add-to-list 'default-frame-alist '(font . "fontset-myfontset"))
