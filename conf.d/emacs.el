(set-language-environment 'Japanese)

(unless (eq (get-architecture) :windows)
  (set-locale-environment "ja_JP.UTF-8")
  (set-default-coding-systems 'utf-8-unix)
  (set-buffer-file-coding-system 'utf-8-unix))

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'help-for-help)
(global-set-key (kbd "M-g") 'goto-line)

(global-font-lock-mode t)
(show-paren-mode t)
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))
(transient-mark-mode t)

(setq inhibit-startup-message t)
(setq tab-width 4)
(setq read-file-name-completion-ignore-case t)

(when (eq window-system 'x)
  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))

(setq comint-buffer-maximum-size 10240)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(put 'narrow-to-region 'disabled nil)
(setq inhibit-startup-message nil)
