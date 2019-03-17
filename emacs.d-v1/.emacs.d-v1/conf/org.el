(setq org-todo-keywords (quote ((sequence "TODO(t)" "DOING(d)" "WAITING(w)" "|" "CANCEL(C)" "DEFERRED(F)" "DONE(D)"))))

(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(add-hook 'org-mode-hook 'org-loader)

(defun org-loader ()
  ;; mode related settings
  (org-indent-mode t)
  (setq truncate-lines nil)
  
  ;; capture & archive
  (setq org-default-notes-file "~/.emacs.d/files/default.org")
  (setq org-agenda-files (list "~/.emacs.d/files/"))
  (setq org-archive-location "~/.emacs.d/files/docs/archive.org::")
  (setq org-refile-targets (quote ((nil :maxlevel . 1) (org-agenda-files :maxlevel . 1))))
  (setq org-capture-templates
        (quote (("t" "todo" entry (file "~/.emacs.d/files/backlog.org")
                 "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                ("d" "doing" entry (file "~/.emacs.d/files/backlog.org")
                 "* BREAK %?\n%U\n%a\n" :clock-in t :clock-resume t))))

  ;; design
  (defvar org-level-star (make-face 'org-level-star))
  (font-lock-add-keywords 'org-mode (list (list (concat "\\*") '(0 org-level-star t)) ))
  (set-face-attribute 'org-level-star nil :inherit 'font-lock-comment-face)
  (set-face-attribute 'org-level-1 nil :inherit 'font-lock-keyword-face :height 125)
  (set-face-attribute 'org-level-2 nil :inherit 'font-lock-keyword-face :height 125)
  (set-face-attribute 'org-level-3 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-level-4 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-level-5 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-level-6 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-link nil :inherit 'font-lock-warning-face)
  (set-face-attribute 'org-date nil :foreground (face-foreground 'font-lock-warning-face))
  (set-face-attribute 'org-tag nil :inherit 'font-lock-warning-face)

  ;; Task status and state
  (setq org-use-fast-todo-selection t)
  (add-hook 'org-after-todo-state-change-hook
            (lambda () (cond
                        ((and (org-entry-is-done-p) (org-clock-is-active)) (org-clock-out))
                        ((equal (org-get-todo-state) "DOING") (org-clock-in))
                        ((org-clock-is-active) (org-clock-out)))))

  ;; encrypt
  (require 'org-crypt)
  (require 'epa-file)
  (setq auto-save-default nil)
  (epa-file-enable)
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance (quote ("crypt")))
  (setq org-crypt-key nil)
  (setq auto-save-default nil)
  ;;(global-set-key (kbd "C-c d") 'org-decrypt-entry)

  
  ;; org mode export
  (setq org-html-head "<meta http-equiv='X-UA-Compatible' content='IE=edge'><meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'><style>html{touch-action:manipulation;-webkit-text-size-adjust:100%}body{padding:0;margin:0;background:#f2f6fa;color:#3c495a;font-weight:normal;font-size:15px;font-family:'San Francisco','Roboto','Arial',sans-serif}h2,h3,h4,h5,h6{font-family:'Trebuchet MS',Verdana,sans-serif;color:#586b82;padding:0;margin:20px 0 10px 0;font-size:1.1em}h2{margin:30px 0 10px 0;font-size:1.2em}a{color:#3fa7ba;text-decoration:none}p{margin:6px 0;text-align:justify}ul,ol{margin:0;text-align:justify}ul>li>code{color:#586b82}pre{white-space:pre-wrap}#content{width:96%;max-width:1000px;margin:2% auto 6% auto;background:white;border-radius:2px;border-right:1px solid #e2e9f0;border-bottom:2px solid #e2e9f0;padding:0 115px 150px 115px;box-sizing:border-box}#postamble{display:none}h1.title{background-color:#343C44;color:#fff;margin:0 -115px;padding:60px 0;font-weight:normal;font-size:2em;border-top-left-radius:2px;border-top-right-radius:2px}@media (max-width: 1050px){#content{padding:0 70px 100px 70px}h1.title{margin:0 -70px}}@media (max-width: 800px){#content{width:100%;margin-top:0;margin-bottom:0;padding:0 4% 60px 4%}h1.title{margin:0 -5%;padding:40px 5%}}pre,.verse{box-shadow:none;background-color:#f9fbfd;border:1px solid #e2e9f0;color:#586b82;padding:10px;font-family:monospace;overflow:auto;margin:6px 0}#table-of-contents{margin-bottom:50px;margin-top:50px}#table-of-contents h2{margin-bottom:5px}#text-table-of-contents ul{padding-left:15px}#text-table-of-contents>ul{padding-left:0}#text-table-of-contents li{list-style-type:none}#text-table-of-contents a{color:#7c8ca1;font-size:0.95em;text-decoration:none}table{border-color:#586b82;font-size:0.95em}table thead{color:#586b82}table tbody tr:nth-child(even){background:#f9f9f9}table tbody tr:hover{background:#586b82!important;color:white}table .left{text-align:left}table .right{text-align:right}.todo{font-family:inherit;color:inherit}.done{color:inherit}.tag{background:initial}.tag>span{background-color:#eee;font-family:monospace;padding-left:7px;padding-right:7px;border-radius:2px;float:right;margin-left:5px}#text-table-of-contents .tag>span{float:none;margin-left:0}.timestamp{color:#7c8ca1}@media print{@page{margin-bottom:3cm;margin-top:3cm;margin-left:2cm;margin-right:2cm;font-size:10px}#content{border:none}}</style>")
  (setq org-html-validation-link nil)
  (setq org-html-creator-string ""))



