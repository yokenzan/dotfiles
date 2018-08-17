(global-set-key "\C-h" 'delete-backward-char)


; バックアップファイルをつくらない
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq next-line-add-newlines nil)

; フォント
(add-to-list 'default-frame-alist '(font . "Osaka―等幅-11"))


(global-linum-mode t)
(column-number-mode t)

(show-paren-mode t)

(setq scroll-step 1)


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (php-mode ddskk))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(when (require 'skk nil t)
  (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study)
)
