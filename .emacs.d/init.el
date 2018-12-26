;; -------------------------------------------------------------------------------------
;; ---------------------      INITIALIZE       -----------------------------------------
;; -------------------------------------------------------------------------------------

;; SETUP YOUR PROXY IF NEEDED
;; (setq url-proxy-services
;;       '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;         ("http" . "company.com:8080")
;;         ("https" . "company.com:8080")))

;; Old way of loading evil mode - when the git repo was cloned in the emacs.d folder
;(add-to-list 'load-path "~/.emacs.d/evil")
;(require 'evil)
;(evil-mode 1)

;;;
; Installed packages
; magit
; projectile
; neotree
; powerline
;;;

(global-set-key (kbd "C-x g") 'magit-status)

;; change the size of initial frame
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 150))

;; neotree theme
(setq neo-theme (if (display-graphic-p) 'nerd))


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(use-package evil
  :ensure t
  :defer .1 ;; don't block emacs when starting, load evil immediately after startup
  :init
  (setq evil-want-integration nil) ;; required by evil-collection
  (setq evil-want-keybinding nil) ;; also required by evil-collection
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t) ;; like vim's 'splitright'
  (setq evil-split-window-below t) ;; like vim's 'splitbelow'
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode)

  ;; vim-like keybindings everywhere in emacs
  (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))

  ;; gl and gL operators, like vim-lion
  (use-package evil-lion
    :ensure t
    :bind (:map evil-normal-state-map
                ("g l " . evil-lion-left)
                ("g L " . evil-lion-right)
                :map evil-visual-state-map
                ("g l " . evil-lion-left)
                ("g L " . evil-lion-right)))

  ;; gc operator, like vim-commentary
  (use-package evil-commentary
    :ensure t
    :bind (:map evil-normal-state-map
                ("gc" . evil-commentary)))

  ;; gx operator, like vim-exchange
  ;; NOTE using cx like vim-exchange is possible but not as straightforward
  (use-package evil-exchange
    :ensure t
    :bind (:map evil-normal-state-map
                ("gx" . evil-exchange)
                ("gX" . evil-exchange-cancel)))

  ;; gr operator, like vim's ReplaceWithRegister
  (use-package evil-replace-with-register
    :ensure t
    :bind (:map evil-normal-state-map
                ("gr" . evil-replace-with-register)
                :map evil-visual-state-map
                ("gr" . evil-replace-with-register)))

  ;; * operator in vusual mode
  (use-package evil-visualstar
    :ensure t
    :bind (:map evil-visual-state-map
                ("*" . evil-visualstar/begin-search-forward)
                ("#" . evil-visualstar/begin-search-backward)))

  ;; ex commands, which a vim user is likely to be familiar with
  (use-package evil-expat
    :ensure t
    :defer t)

  ;; visual hints while editing
  (use-package evil-goggles
    :ensure t
    :config
    (evil-goggles-use-diff-faces)
    (evil-goggles-mode))

  ;; like vim-surround
  (use-package evil-surround
    :ensure t
    :commands
    (evil-surround-edit
     evil-Surround-edit
     evil-surround-region
     evil-Surround-region)
    :init
    (evil-define-key 'operator global-map "s" 'evil-surround-edit)
    (evil-define-key 'operator global-map "S" 'evil-Surround-edit)
    (evil-define-key 'visual global-map "S" 'evil-surround-region)
    (evil-define-key 'visual global-map "gS" 'evil-Surround-region))

  (message "Loading evil-mode...done"))

;; -------------------------------------------------------------------------------------
;; ----------------------------    THEME     -------------------------------------------
;; -------------------------------------------------------------------------------------

;(load-theme 'wombat)
(load-theme 'wombat t t)
(add-hook 'buffer-list-update-hook
          (lambda ()
            (cond
             ((and (eq major-mode 'scheme-mode)
                   (not (memq 'wombat custom-enabled-themes)))
              ;(disable-theme 'tango)
              (enable-theme 'wombat))
             ((and (eq major-mode 'haskell-mode)
                   (not (memq 'tango custom-enabled-themes)))
              (disable-theme 'wombat)
             ; (enable-theme 'tango)))))
             ))))
;; a great font: https://www.fontyukle.net/en/Monaco.ttf
(condition-case nil
    (set-default-font "Monaco")
  (error nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "APPL" :family "Monaco"))))
 '(evil-goggles-change-face ((t (:inherit diff-removed))))
 '(evil-goggles-delete-face ((t (:inherit diff-removed))))
 '(evil-goggles-paste-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-add-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-change-face ((t (:inherit diff-changed))))
 '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-removed))))
 '(evil-goggles-yank-face ((t (:inherit diff-changed))))
 '(fringe ((t (:background "#242424"))))
 '(ido-first-match ((t (:inherit 'font-lock-comment-face))))
 '(ido-only-match ((t (:inherit 'font-lock-comment-face))))
 '(ido-subdir ((t (:inherit 'font-lock-keyword-face))))
 '(linum ((t (:inherit (shadow default) :background "#191919" :foreground "#505050")))))





;; -------------------------------------------------------------------------------------
;; ---------------------    ENHANCEMENTS     -------------------------------------------
;; -------------------------------------------------------------------------------------

;; remove unecessary UI
(menu-bar-mode -1)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(setq visible-bell 1)
(setq ring-bell-function 'ignore)

;; startup screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; remove whitespace before saving
(add-hook 'before-save-hook 'whitespace-cleanup)

;; faster to quit
(fset 'yes-or-no-p 'y-or-n-p)

;; highlight selected text
(transient-mark-mode t)

;; set path
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(add-to-list 'exec-path "/usr/local/bin")

;; display matching parenthesis
(show-paren-mode 1)

;; move faster up and down faster
(global-set-key (kbd "M-n") (kbd "C-u 5 C-n"))
(global-set-key (kbd "M-p") (kbd "C-u 5 C-p"))

;; usefull stuff before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook '(lamdba () (require 'saveplace)(setq-default save-place t)))

;; refresh buffers when any file change
(global-auto-revert-mode t)

;; display time
(load "time" t t)
(display-time)

;; track recently opened file
(recentf-mode t)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 50)

;; display pictures and other compressed files
(setq auto-image-file-mode t)
(setq auto-compression-mode t)

;; line and column numbering
(column-number-mode 1)
(line-number-mode 1)

;; code folding
(global-set-key (kbd "C-c C-d") 'hs-hide-all)
(global-set-key (kbd "C-c C-f") 'hs-show-all)
(global-set-key (kbd "C-c C-c") 'hs-toggle-hiding)
(add-hook 'prog-mode-hook #'(lambda () (hs-minor-mode t) ))

;; Search using regexp
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)

;; Usable on OSX and windows
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'alt)
(setq mac-right-option-modifier 'super)
(setq w32-get-true-file-attributes nil)
(setq vc-handled-backends nil)
(remove-hook 'find-file-hooks 'vc-find-file-hook)

;; scroll
(setq scroll-step 1)
(setq scroll-conservatively 10)
(setq scroll-margin 7)
(setq scroll-conservatively 5)

;; indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq standard-indent 4)
(setq indent-line-function 'insert-tab)
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq indent-tabs-mode nil)

;; disable backup files
(setq make-backup-files nil)

;; auto wraping
(set-default 'truncate-lines t)
(add-hook 'text-mode-hook (lambda () (setq truncate-lines nil)))

;; setup ido for selecting file
(ido-mode)
(setq ido-enable-flex-matching t)
(setq resize-mini-windows t)
(add-hook 'minibuffer-setup-hook
      (lambda () (setq truncate-lines nil)))
(setq ido-decorations '("\n-> " "" "\n   " "\n   ..."
            "[" "]" " [No match]" " [Matched]"
            " [Not readable]" " [Too big]" " [Confirm]"))
(add-to-list 'ido-ignore-buffers "*Messages*")
(add-to-list 'ido-ignore-buffers "*Buffer*")
(add-to-list 'ido-ignore-buffers "*ESS*")
(add-to-list 'ido-ignore-buffers "*NeoTree*")
(add-to-list 'ido-ignore-buffers "*Completions*")
(add-to-list 'ido-ignore-buffers "*Help*")



;; line wrap
(setq linum-format "%d ")
;;(global-linum-mode 1)

;; usefull shortcuts
(global-set-key [f3] 'comment-region)
(global-set-key [f4] 'uncomment-region)
(global-set-key [f5] 'eshell)
(global-set-key [f11] 'toggle-frame-fullscreen)
(global-set-key (kbd "C-h C-s") 'info-apropos)

;; ARTIST MODE
;(eval-after-load "artist" '(define-key artist-mode-map [(down-mouse-3)] 'artist-mouse-choose-operation))

;; EWW - emacs web browser
;(setq eww-search-prefix "https://www.google.com.au/search?q=")
;(setq shr-color-visible-luminance-min 78) ;; improve readability (especially for google search)
;(setq url-user-agent "User-Agent: Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7\n")
;(global-set-key (kbd "C-c b") 'eww)


;; I think this is redundant... need to fix
;; -------------------------
;; Setup the package manager
;; -------------------------
(defun load-package-manager ()
  (package-initialize)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")))
(add-hook 'after-init-hook 'load-package-manager)



;; Hide left line indicator
(setf (cdr (assq 'continuation fringe-indicator-alist))
      '(nil nil) ;; no continuation indicators
      ;; '(nil right-curly-arrow) ;; right indicator only
      ;; '(left-curly-arrow nil) ;; left indicator only
      ;; '(left-curly-arrow right-curly-arrow) ;; default
      )


;; Window split line
(set-face-attribute 'vertical-border nil :foreground "#303030")



;; -------------------------------------------------------------------------------------
;; ---------------------      PLUGINS          -----------------------------------------
;; -------------------------------------------------------------------------------------

;; Our plugins configuration will leave under the conf folder, so let's load this up:
(mapc
 (lambda(path) (load-file path))
 (condition-case nil
     (directory-files "~/.emacs.d/conf/" t "\.el$")
   (error (make-directory "~/.emacs.d/conf/"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(haskell-mode neotree projectile magit evil-surround evil-goggles evil-expat evil-visualstar evil-replace-with-register evil-exchange evil-commentary evil-lion evil-collection evil use-package)))
