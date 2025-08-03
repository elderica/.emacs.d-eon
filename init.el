;;; init.el --- init.el -*- lexical-binding: t; -*-

;;; Commentary:
;;; elderica's Emacs init.el

;;; Code:
;; this enables this running method
;; > /usr/bin/emacs -q -l ~/.debug.emacs.d/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name (file-name-directory
                             (or load-file-name
                                 byte-compile-current-file))))))
  
;; load eon.el
(load-file (expand-file-name "~/.emacs.onboard/eon.el"))
;; unset keys since they are conflicting some escape sequences.
(keymap-global-unset "M-[")
(keymap-global-unset "M-]")

(customize-set-variable
 'custom-file (expand-file-name "~/.emacs.d/custom.el"))
(when (file-exists-p custom-file) (load custom-file))

(custom-set-faces
 '(which-func ((t (:foreground "lawn green"))) nil))
(which-function-mode 1)

(keymap-global-set "M-m" '#[nil ((forward-whitespace 1)) nil nil nil nil])
(keymap-global-set "M-n" '#[nil ((forward-whitespace -1)) nil nil nil nil])

;; duplicate region or line
(keymap-global-set "C-c d" 'duplicate-dwim)

;; Shift-{left,right,up,down} to switch windows
(windmove-default-keybindings 'shift)

;; https://www.emacswiki.org/emacs/IndentingC
(require 'cc-styles)
(c-add-style "openbsd"
             '("bsd"
               (c-backspace-function . delete-backward-char)
               (c-syntactic-indentation-in-macros . nil)
               (c-tab-always-indent . nil)
               (c-hanging-braces-alist
                (block-close . c-snug-do-while))
               (c-offsets-alist
                (arglist-cont-nonempty . *)
                (statement-cont . *))
               (indent-tabs-mode . t)))
(setf (alist-get 'other c-default-style) "openbsd")

(provide 'init)
;;; init.el ends here
