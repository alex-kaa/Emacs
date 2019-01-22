;; -*- coding: utf-8; lexical-binding: t; -*-


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "yandex-browser")
 '(column-number-mode t)
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                  (company-dabbrev-code company-gtags company-etags company-keywords)
                  company-oddmuse company-dabbrev company-abbrev company-elisp company-ispell)))
 '(company-selection-wrap-around t)
 '(global-page-break-lines-mode t)
 '(menu-bar-mode nil)
 '(minibuffer-prompt-properties
   (quote
    (read-only t cursor-intangible t face minibuffer-prompt)))
 '(org-export-backends (quote (html)))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . system)
     ("\\.pdf\\'" . default))))
 '(org-html-doctype "html5")
 '(org-html-head-include-default-style nil)
 '(org-html-head-include-scripts nil)
 '(org-html-html5-fancy t)
 '(org-html-htmlize-font-prefix "htmlize-font-")
 '(org-html-htmlize-output-type (quote css))
 '(org-html-indent t)
 '(org-html-infojs-template "")
 '(org-html-link-home "")
 '(org-html-link-use-abs-url nil)
 '(org-html-use-unicode-chars t)
 '(package-selected-packages
   (quote
    (company-php php-mode editorconfig speed-type rjsx-mode yasnippet company direx markdown-mode page-break-lines magit fish-mode company-web company-tern tern js2-mode smex company-shell)))
 '(save-place-mode t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-echo-common ((t (:foreground "chocolate"))))
 '(company-scrollbar-bg ((t (:background "dim gray"))))
 '(company-scrollbar-fg ((t (:background "light gray"))))
 '(company-tooltip ((t (:background "gray20" :foreground "gainsboro"))))
 '(company-tooltip-annotation ((t (:foreground "navajo white"))))
 '(company-tooltip-common ((t (:foreground "white"))))
 '(company-tooltip-selection ((t (:background "dim gray")))))


(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; MELPA
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/")
               t))


(setq-default abbrev-mode nil)
(setq save-abbrevs 'silently)

(global-subword-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(electric-indent-mode 1)
(setq sentence-end-double-space nil)
(progn (setq-default indent-tabs-mode nil))

(setq inhibit-splash-screen t)
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")
(setq bookmark-save-flag 1)

(setq search-whitespace-regexp "[-_ /t/n]+")
(defalias 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode 1) ; automatically update buffer.

;; Recent files.
(require 'recentf)
(recentf-mode 1)
;; (desktop-save-mode 1)


;; Ido mode setup.
;; Suggestions during buffer switch and find file.
(require 'ido)
(ido-mode 1)
(progn
  ;; Show choices in column.
  (if (version< emacs-version "25")
      (progn
        (make-local-variable 'ido-separator)
        (setq ido-separator "\n"))
    (progn
      (make-local-variable 'ido-decorations)
      (setf (nth 2 ido-decorations) "\n")))
  (setq ido-enable-flex-matching t)
  ;; Use current pane for newly opened files.
  (setq ido-default-file-method 'selected-window)
  ;; Use current pane for newly switched buffer.
  (setq ido-default-buffer-method 'selected-window)
  ;; Don't suggest when naming a new file.
  (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil))
(setq max-mini-window-height 0.5)


;; Yasnippet.
(require 'yasnippet)
(yas-global-mode 1)
;; TODO: (define-key yas-minor-mode-map (kbd "") 'yas-new-snippet)


;; ;; Icomplete mode setup.
;; ;; Minibuffer enhanced completion.
;; (require 'icomplete)
;; (icomplete-mode 1)
;; (progn
;;   ;; Show choices in column.
;;   (setq icomplete-separator "\n")
;;   (setq icomplete-hide-common-prefix nil)
;;   (setq icomplete-in-buffer t)

;;   (define-key icomplete-minibuffer-map (kbd "<right>") 'icomplete-forward-completions)
;;   (define-key icomplete-minibuffer-map (kbd "<left>") 'icomplete-backward-completions)
;;   )


;; Don't autosave.
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Send backups to a different folder.
(setq backup-by-copying t)
(defun my-backup-file-name (my-path)
  "Return a new path of a given file. Create if necessary."
  (let* (
         (backupRootDir "~/.emacs.d/.backup/")
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir my-path "~"))))
    (make-directory (file-name-directory backupFilePath)
                    (file-name-directory backupFilePath))
    backupFilePath
    ))
(setq make-backup-file-name-function 'my-backup-file-name)


;; Dired. TODO see batch rename.
(require 'dired)
(require 'dired-x)

;; (defun xah-dired-mode-setup ()
;;   "A hook for `dired-mode'."
;;   (dired-hide-details-mode 1))
;; (add-hook 'dired-mode-hook 'xah-dired-mode-setup)

(setq dired-recursive-copies (quote always)) ; no asking.
(setq dired-recursive-deletes (quote top)) ; ask once.
(setq dired-dwim-target t)

(define-key dired-mode-map (kbd "r") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "g") (lambda () (interactive) (find-alternate-file "..")))

;; TODO cycle instead of prompt.
;; TODO show/hide hidden?
(defun xah-dired-sort ()
  "Sort dired dir listing. Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2015-07-30"
  (interactive)
  (let ($sort-by $arg)
    (setq $sort-by (ido-completing-read "Sort by:" '("date" "size" "name" "folder")))
    (cond
     ((equal $sort-by "name") (setq $arg "-lh --time-style long-iso --group-directories-first"))
     ((equal $sort-by "date") (setq $arg "-lh --time-style long-iso -t --group-directories-first"))
     ((equal $sort-by "size") (setq $arg "-lh --time-style long-iso -S --group-directories-first"))
     ((equal $sort-by "folder") (setq $arg "-lh --time-style long-iso --group-directories-first"))
     (t (error "Error: couldn't sort." )))
    (dired-sort-other $arg )))

(define-key dired-mode-map (kbd "s") 'xah-dired-sort)


;; Minibuffer.
(savehist-mode 1)


;; Miscellaneous.
;; (setq pop-up-frames t)


;; Hippie-expand setup.
(setq hippie-expand-try-functions-list
      '(
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        ;; try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
        ;; try-expand-all-abbrevs
        ;; try-expand-list
        ;; try-expand-line
        ))


;; Fonts.
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9"))
;; (when (member "Symbola" (font-family-list))
;;   (set-fontset-font t 'unicode "Symbola" nil 'prepend))


;; Disable warnings.
(progn
  ;; Stop warning prompt for some commands: there's always undo.
  (put 'narrow-to-region 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'erase-buffer 'disabled nil)
  (put 'scroll-left 'disabled nil)
  (put 'dired-find-alternate-file 'disabled nil)
  )


;; Loading packages.
;; Xah packages.
(add-to-list 'load-path "~/.emacs.d/xah/")
;; xah-fly-keys
(require 'xah-fly-keys)
(xah-fly-keys 1)
;; xah-elisp-mode
(autoload 'xah-elisp-mode "xah-elisp-mode" "xah emacs lisp major mode." t)
(add-to-list 'auto-mode-alist '("\\.el\\'" . xah-elisp-mode))
;; xah-find
(autoload 'xah-find-text "xah-find" "find replace" t)
(autoload 'xah-find-text-regex "xah-find" "find replace" t)
(autoload 'xah-find-replace-text "xah-find" "find replace" t)
(autoload 'xah-find-replace-text-regex "xah-find" "find replace" t)
(autoload 'xah-find-count "xah-find" "find replace" t)


;; Company.
(require 'company)
(require 'company-web-html)
(add-hook 'after-init-hook 'global-company-mode)
;; (add-to-list 'company-backends '(company-fish-shell
;;                                  company-shell-env
;;                                  company-files
;;                                  company-shell))

;; HTML
;; (add-hook 'html-mode-hook 'company-web-html)
(require 'xah-html-mode)
;; (add-to-list 'auto-mode-alist '("\\.html\\'" . xah-html-mode))

(defun kaa-html-company ()
  "Initialise html company completion."
  (set (make-local-variable 'company-backends) '(company-web-html))
  (company-mode t))
(add-hook 'xah-html-mode-hook 'kaa-html-company)

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
;; Tern.
(add-hook 'js2-mode-hook 'tern-mode)


;; Fish.
(defun kaa-fish-indent-before-save ()
  "Run fish_indent before save."
  (add-hook 'before-save-hook 'fish_indent-before-save))
(add-hook 'fish-mode-hook 'kaa-fish-indent-before-save)
