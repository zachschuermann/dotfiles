;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Zach Schuermann's private configuration here

;; TODO make install list
;; Stack installed hlint
;; Home-brew: shellcheck, hlint, glslang, sbcl, pandoc,
;; cabal-install, gtk+, gtk-mac-integration
;;
;; Brew cask install racket
;;
;; Cargo: rust racer, toolchain, src, etc.

;; TODO change haskell keybindings: C-c C-j jump to def, etc

;; gopath hacks
(defvar gopathroot "/Users/zach/go" "default gopath")
(setenv "GOPATH"
        (concat gopathroot
                ":/Users/zach/Documents/fall19/class/distributed-systems/4113"))

;; path hacks
(setenv "PATH"
        (concat
         gopathroot "/bin:"
         "/usr/local/bin/:"
         (getenv "PATH")))
(add-to-list 'exec-path "/Users/zach/go/bin")
(add-to-list 'exec-path "/usr/local/bin/")

(setq haskell-interactive-popup-errors 'nil)
;; (setq exec-path (append '(concat gopathroot "/bin:") exec-path))

;; set notes dir
;;(require 'org)
;;(setq org-directory "~/Documents/home-base")
;;(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq doom-theme 'doom-dracula)

;; speed up company
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

;; macos config for mapping command to meta
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; macos python -> python3 interpreter for babel
(setq org-babel-python-command "python3")

;; use j/k for org mode up/down
(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup))

;; auto line-wrapping
;; set to 80
(setq-default auto-fill-function 'do-auto-fill)
(setq fill-column 99)

;; default for remote editing --> ssh
(setq tramp-default-method "ssh")

;; slower scroll speed
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;; use cargo.el with rust-mode
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;; custom background color
(custom-set-faces
  '(default ((t (:background "#1d2021")))))
(custom-set-faces
  '(default ((t (:foreground "#f7f8f9")))))

;; full-screen window size on startup
;; DEPRECATED
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

;; handle underscores as word character
(defadvice evil-inner-word (around underscore-as-word activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

(defadvice evil-forward-word-begin (around underscore-as-word0 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

(defadvice evil-forward-word-end (around underscore-as-word1 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

(defadvice evil-backward-word-begin (around underscore-as-word2 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

(defadvice evil-backward-word-end (around underscore-as-word3 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

(defadvice evil-a-word (around underscore-as-word4 activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))
