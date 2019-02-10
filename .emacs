(global-set-key "\C-h" 'delete-backward-char)


; バックアップファイルをつくらない
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq next-line-add-newlines nil)

; フォント
; (add-to-list 'default-frame-alist '(font . "Osaka―等幅-11"))


;; 行番号
(global-linum-mode t)
(setq linum-format "%4d ")
(column-number-mode t)

(show-paren-mode t)


(setq scroll-conservatively 1)
(setq scroll-margin 4)

;; カーソル行ハイライトON
(global-hl-line-mode)
;; メニューバーOFF
(menu-bar-mode -1)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (gruvbox-dark-hard)))
 '(custom-safe-themes
 '(package-selected-packages
   (quote
    (projectile flycheck-phpstan magit gruvbox-theme ivy company-phpactor company-phpactor\
		phpactor company ## php-mode ddskk)))


(when (require 'skk nil t)
  (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study)
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

(setq vc-follow-symlinks t)

(ivy-mode 1)


;; MRUリストの設定
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)


;; SKKの設定
(setq skk-server-host "localhost")
(setq skk-server-portnum 55100)
(setq skk-share-private-jisyo t)
(setq skk-large-jisyo "~/.skk/SKK-JISYO.L")
(setq skk-show-icon t)
(setq skk-show-annotation t)



;; PHPのLINT設定
(defun my-php-mode-hook ()
  "My PHP-mode hook."
  (require 'flycheck-phpstan)
  (flycheck-mode t)
  (flycheck-select-checker 'phpstan))

(add-hook 'php-mode-hook 'my-php-mode-hook)


;; (global-flycheck-mode)
;; (setq flycheck-indication-mode 'left-fringe)
;; (setq flycheck-check-syntax-automatically '(mode-enabled save))


(setq display-time-day-and-date t)  ;; 曜日・月・日
(setq display-time-24hr-format t)   ;; 24時表示
(display-time-mode t)


(setq frame-title-format "%f")
