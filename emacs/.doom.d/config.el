;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Zach Schuermann's private configuration here

;; gopath hacks
(setenv "GOPATH" "/Users/Zach/go:/Users/Zach/Desktop/fall19/class/distributed-systems/4113:/home/zach/dev/assignments-schuermannator/")

;; lul this is wrong
;; (setenv "PATH" "$PATH:$GOPATH/bin")

;; set notes dir
(require 'org)
(setq org-directory "~/Documents/home-base")
(setq org-default-notes-file (concat org-directory "/notes.org"))

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
