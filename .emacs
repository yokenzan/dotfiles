; (global-set-key "\C-h" 'delete-backward-char)
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "C-x C-M-f") 'project-find-file)


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
 '(column-number-mode t)
 '(custom-enabled-themes (quote (gruvbox-dark-hard)))
 '(custom-safe-themes
   (quote
    ("a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" "7f89ec3c988c398b88f7304a75ed225eaac64efa8df3638c815acc563dfd3b55" "595617a3c537447aa7e76ce05c8d43146a995296ea083211225e7efc069c598f" "fd3c7bd752f48dcb7efa5f852ef858c425b1c397b73851ff8816c0580eab92f1" "3da031b25828b115c6b50bb92a117f5c0bbd3d9d0e9ba5af3cd2cb9db80db1c2" "a622aaf6377fe1cd14e4298497b7b2cae2efc9e0ce362dade3a58c16c89e089c" "2a9039b093df61e4517302f40ebaf2d3e95215cb2f9684c8c1a446659ee226b9" default)))
 '(display-time-mode t)
 '(package-selected-packages
   (quote
    (projectile flycheck-phpstan magit gruvbox-theme ivy company-phpactor company-phpactor\
		phpactor company ## php-mode ddskk)))
 '(pdf-view-midnight-colors (quote ("#fdf4c1" . "#1d2021")))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Sarasa Mono T TC" :foundry "PfEd" :slant normal :weight normal :height 100 :width normal)))))


(when (require 'skk nil t)
  (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study)
  (setq skk-server-host "localhost")
  (setq skk-server-portnum 55100)
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


(global-flycheck-mode)
(setq flycheck-indication-mode 'left-fringe)
(setq flycheck-check-syntax-automatically '(mode-enabled save))


(setq display-time-day-and-date t)  ;; 曜日・月・日
(setq display-time-24hr-format t)   ;; 24時表示
(display-time-mode t)


(setq frame-title-format "%f")

(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")


(setq text-mode-hook 'turn-off-auto-fill)
