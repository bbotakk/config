(xterm-mouse-mode t) ;; enable mouse
(beacon-mode t) ;; hl the cursor when jumping for better orientation
(whitespace-mode t) ;; hl whitespace
(display-time-mode nil) ;; no clock; that's what a statusbar is for
(display-battery-mode nil) ;; no battery info; that's what a statusbar is for
(global-subword-mode t)
(global-auto-revert-mode t)
(evil-snipe-override-mode t)
(save-place-mode t)
(+global-word-wrap-mode t)

(setq global-auto-revert-non-file-buffers t
      hscroll-margin 1
      scroll-margin 10
      scroll-preserve-screen-position t
      auto-save-default t
      company-idle-delay 0
      evil-vsplit-window-right t
      evil-ex-substitute-global t
      evil-move-cursor-back t
      evil-kill-on-visual-paste nil
      display-line-numbers-type 'visual
      which-key-idle-delay 0
      undo-limit 80000000
      browse-url-generic-program "firefox"
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't
      scroll-step 1
      doom-modeline-height 15
      doom-modeline-bar-width 5
      doom-modeline-persp-name t
      evil-snipe-scope 'visible
      evil-snipe-auto-scroll t
      evil-snipe-repeat-keys t
      right-fringe-width 10
      +global-word-wrap-mode t
      rainbow-mode t
      org-num-mode t
      )

(setq doom-leader-key "SPC"
      doom-localleader-key ",") ;; hit <spc> twice

(map! :leader
      (:prefix "t"
               "l" 'doom/toggle-line-numbers
               "H" 'global-hl-line-mode
               "t" 'toggle-truncate-lines
               "C" 'global-company-mode
               "e" 'counsel-load-theme
               "S" 'toggle-line-spacing
               "n" 'org-num-mode
               "d" 'peep-dired
               "D" 'dired-view-file
               "t" 'user/insert-todays-date
               )
      (:prefix "i"
               "d" 'user/insert-any-date
               "D" 'user/insert-todays-date
               )
      ;;remove unused
      "'" nil
      "`" nil
      "." nil
      "," nil
      "SPC" nil
      "/" nil
      ":" nil
      )

(map!
  :map  'override
  :nvi "M-j" 'evil-window-prev
  :nvi "M-k" 'evil-window-next
  :nvi "M-s" 'evil-window-vsplit
  :nvi "M-q" 'user/save-quit
  :nvi "M-x" 'dired-jump
  :nvi "M-f" 'counsel-fzf
  :nvi "M-r" 'counsel-recentf
  :nvi "M-h" '+lookup/documentation
  :nvi "M-'" '+ivy/switch-buffer
  :nvi "M-=" 'evil-window-increase-width
  :nvi "M--" 'evil-window-decrease-width
  :nvi "M-/" '+default/search-project
  :nvi "M-;" 'counsel-M-x
  :nvi "C-c" 'evil-force-normal-state ;; incase all else fails
  :nvi "C--" 'doom/decrease-font-size
  :nvi "C-=" 'doom/increase-font-size
  :nvi "C-0" 'doom/reset-font-size
  )

(map!
   :nvm "C-u"   'user/page-up
   :nvm "C-d"   'user/page-down
   :nvm "C-o"   'user/jump-backward
   :nvm "C-i"   'user/jump-forward
   :nvm "n"     'user/next-match
   :nvm "N"     'user/prev-match
   :nvm "Q"     'evil-execute-last-recorded-macro
   :nvm "U"     'evil-redo

  )

(map! :map dired-mode-map
      :n "RET" #'dired-open-file
      :n "j" #'evil-next-line
      :n "k" #'evil-previous-line
      :n "h" #'dired-up-directory
      :n "l" #'dired-open-file
      :n "m" #'dired-mark
      :n "t" #'dired-toggle-marks
      :n "u" #'dired-unmark
      :n "y" #'dired-do-copy
      :n "r" #'dired-do-rename
      :n "d" #'dired-do-delete
      :n "F" #'dired-create-empty-file
      :n "D" #'dired-create-directory
      :n "T" #'dired-do-touch
      :n "x" #'dired-do-chmod
      :n "w" #'dired-do-chown
      :n "p" #'dired-do-print
      :n "y" #'dired-copy-filenamecopy-filename-as-kill
      :n "z" #'dired-do-compress
      :n "." #'dired-omit-mode
      :n "o" #'user/dired-order
      :n "s" #'dired-toggle-sudo)

(map! :map peep-dired-mode-map
      :n "j" #'peep-dired-next-file
      :n "k" #'peep-dired-prev-file)

(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(defun user/dired-order()
  "Sort dired dir listing in different ways.
Prompt for a choice."
  (interactive)
  (let (xsortBy xarg)
    (setq xsortBy (completing-read "Sort by:" '( "date" "size" "name" )))
    (cond
     ((equal xsortBy "name") (setq xarg "-Al "))
     ((equal xsortBy "date") (setq xarg "-Al -t"))
     ((equal xsortBy "size") (setq xarg "-Al -S"))
     ((equal xsortBy "dir") (setq xarg "-Al --group-directories-first"))
     (t (error "logic error 09535" )))
    (dired-sort-other xarg )))

(defun user/next-match ()
  (interactive)
  (evil-ex-search-next)
  (evil-scroll-line-to-center nil)
  )

(defun user/previous-match ()
  (interactive)
  (evil-ex-search-previous)
  (evil-scroll-line-to-center nil)
  )

(defun user/page-up ()
  (interactive)
  (evil-scroll-page-up 1)
  (evil-scroll-line-to-center nil)
  )

(defun user/page-down ()
  (interactive)
  (evil-scroll-page-down 1)
  (evil-scroll-line-to-center nil)
  )

(defun user/jump-backward ()
  (interactive)
  (evil-jump-backward 1)
  (evil-scroll-line-to-center nil)
  )

(defun user/jump-forward ()
  (interactive)
  (evil-jump-forward 1)
  (evil-scroll-line-to-center nil)
  )

(defun user/insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))

(defun user/insert-todays-date (prefix)
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%A, %B %d, %Y")
                 ((equal prefix '(4)) "%m-%d-%Y")
                 ((equal prefix '(16)) "%Y-%m-%d"))))
    (insert (format-time-string format))))

(defun user/save-quit ()
  (interactive)
  (evil-save-modified-and-close nil)
  (balance-windows)
  )

(defun user/next-match ()
  (interactive)
  (evil-ex-search-next 1)
  (evil-scroll-line-to-center nil)
  )

(defun user/prev-match ()
  (interactive)
  (evil-ex-search-previous 1)
  (evil-scroll-line-to-center nil)
  )

(ivy-posframe-mode t)
(setq ivy-posframe-display-functions-alist
      '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-bottom-center)
        (nil                        . ivy-posframe-display))
      ivy-posframe-height-alist
      '((swiper . 50)
        (dmenu . 50)
        (t . 50)))

(setq dired-omit-files
      (rx (or (seq bol (? ".") "#")             ;; emacs autosave files
              (seq bol "." (not (any ".")))     ;; dot-files
              (seq "~" eol)                     ;; backup-files
              (seq bol "CVS" eol)               ;; CVS dirs
              )))

(setq dired-open-extensions '(
                              ("mkv"    .   "mpv")
                              ("mp4"    .   "mpv")
                              ("mp3"    .   "clementine")
                              ("gif"    .   "sxiv")
                              ("jpeg"   .   "sxiv")
                              ("jpg"    .   "sxiv")
                              ("png"    .   "sxiv")
                              ("pdf"    .   "zathura")
                              ("epub"   .   "zathura")
                              ))

(setq dired-recursive-copies (quote always)
    dired-recursive-deletes (quote top)
    global-auto-revert-non-file-buffers t)

(after! org
    (global-org-modern-mode)
    (visual-line-mode)
    (org-indent-mode)

  (setq org-directory "~/Org"
        org-archive-location "~/Archive/archive.org"
        org-agenda-files '("~/Org")
        org-hide-leading-stars t
        org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil
        org-hide-emphasis-markers t
        org-log-done 'time
        org-table-convert-region-max-lines 20000
        org-emphasis-alist
        '(("*" (bold))
          ("/" italic)
          ("_" underline)
          ("=" redd)
          ("~" code)
          ("+" (:strike-through t)))

        org-use-property-inheritance t
        org-priority-highest ?A
        org-priority-lowest ?
        org-fontify-quote-and-verse-blocks t
        org-priority-faces
        '((?A . 'all-the-icons-red)
          (?B . 'all-the-icons-orange)
          (?C . 'all-the-icons-yellow)
          (?D . 'all-the-icons-green)
          (?E . 'all-the-icons-blue))
        org-log-repeat 'time
        org-startup-with-inline-images t
        org-pretty-entities t
        org-pretty-entities-include-sub-superscripts t
        org-startup-indented t
        org-list-allow-alphabetical t
        org-tags-column 0
        org-fold-catch-invisible-edits 'show-and-error
        org-log-done 'time
        org-log-into-drawer 'LOGBOOK
        org-clock-into-drawer t
        org-export-headline-levels 5
        org-num-max-level 2
        org-refile-use-outline-path 'file
        org-refile-allow-creating-parent-nodes 'confirm
        org-use-sub-superscripts '{}
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-tags-column 0
        org-agenda-compact-blocks t
        org-agenda-show-future-repeats nil
        org-agenda-deadline-faces
        '((1.0 . error)
          (1.0 . org-warning)
          (0.5 . org-upcoming-deadline)
          (0.0 . org-upcoming-distant-deadline))
        org-ellipsis "..."
        org-deadline-warning-days 3
        org-auto-tangle-default t
        org-clock-out-when-done t
        org-clock-persist t ;; Save the running clock and all clock history when exiting Emacs, load it on startup
        org-roam-directory "~/Notes"
        org-roam-dailies-directory "daily/" ;; relative to org roam-dir
        org-roam-completion-everywhere t
        org-auto-align-tags nil
        org-modern-star '("◉" "●" "○" "◈" "◆" "◇" )
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((?* . "•")
                        (?- . "•")
                        (?+ . "➤"))
        org-modern-block-name
        '((t . t)
        ("src" ">>" ">>")
        ("example" "->" "<-")
        ("export" "->" "<-"))
        org-modern-block-fringe nil
        org-modern-todo nil
        org-modern-done nil
        org-modern-done nil
        org-modern-checkbox nil
        ;; org-modern-horizontal-rule (make-string 36 ?─)
        ;; org-modern-progress nil
        ;; org-modern-priority nil
        )
  )

(custom-set-faces!
  '(org-todo                :weight extra-bold :height 1.0 :slant italic )
  '(org-checkbox            :weight extra-bold :height 1.0 :slant normal )
  '(org-priority            :weight extra-bold :height 1.0 :slant italic )
  '(org-special-keyword     :weight normal     :height 1.0 :slant italic )
  '(org-drawer              :weight normal     :height 1.0 :slant italic )
  '(org-tag                 :weight normal     :height 1.0 :slant italic )
  '(org-date                :weight normal     :height 1.0 :slant italic )
  '(org-document-title      :weight ultra-bold :height 1.4 :slant normal )
  '(outline-1               :weight extra-bold :height 1.4 :slant normal )
  '(outline-2               :weight bold       :height 1.3 :slant normal )
  '(outline-3               :weight bold       :height 1.2 :slant normal )
  '(outline-4               :weight semi-bold  :height 1.1 :slant normal )
  '(outline-5               :weight semi-bold  :height 1.1 :slant normal )
  '(outline-6               :weight semi-bold  :height 1.1 :slant normal )
  '(outline-8               :weight semi-bold  :height 1.1 :slant normal )
  '(outline-9               :weight semi-bold  :height 1.1 :slant normal )
  '(markdown-header-face    :weight extra-bold :height 1.7 :slant normal )
  '(markdown-header-face-1  :weight extra-bold :height 1.7 :slant normal )
  '(markdown-header-face-2  :weight bold       :height 1.5 :slant normal )
  '(markdown-header-face-3  :weight bold       :height 1.3 :slant normal )
  '(markdown-header-face-4  :weight semi-bold  :height 1.1 :slant normal )
  '(markdown-header-face-5  :weight semi-bold  :height 1.0 :slant normal )
  '(markdown-header-face-6  :weight semi-bold  :height 1.0 :slant normal )
  '(markdown-header-face-7  :weight semi-bold  :height 1.0 :slant normal )
  '(markdown-header-face-8  :weight semi-bold  :height 1.0 :slant normal )
  )

(after! 'org
(setq org-tag-alist '(("EVENT" . ?e)
                      ("PROJECT" . ?p)
                      ("WRITE" . ?w)
                      ("READ" . ?r)
                      ("STUDY" . ?s)
                      )
      )
)

(after! org
(setq org-todo-keywords '((type
                           "TODO(t)"
                           "PROG(i)"
                           "OPT(o)"
                           "REVIEW(r)"
                           "WAIT(w)"
                           "|"
                           "DONE(d!)"
                           "CANC(C@)"
                           "DELEGATED(D@)"
                           "ASSIGNED(a@)"
                           )
                          )
      )
)

(after! org
(setq org-capture-templates
      '(
        ("t" "TODO: personal"
         entry (file+headline "~/Org/personal_todo.org" "outstanding")
         "* TODO %? \n"
         :empty-lines 1
         )

        ("e" "EVENT: personal"
         entry (file+headline "~/Org/personal_agenda.org" "events")
         "* %? :EVENT: \nSCHEDULED: %^T \nLOCATION: \nMATERIAL:"
         :empty-lines 1
         )

        ("n" "NOTE: personal"
         entry (file "~/Org/personal_note.org")
         "* %?\n%U"
         :empty-lines 1
         )

        ("T" "TODO: work"
         entry (file+headline "~/Org/work_todo.org" "current")
         "* TODO %?\n"
         :empty-lines 1
         )

        ("E" "EVENT: work"
         entry (file+headline "~/Org/work_agenda.org" "events")
         "* %? :EVENT: \nSCHEDULED: %^T \nLOCATION: \nMATERIAL:"
         :empty-lines 1
         )

        ("N" "NOTE @work"
         entry (file "~/Org/work_note.org")
         "* %? \n%U"
         :empty-lines 1
         )

        )
      ))

(setq org-roam-dailies-capture-templates
  '(("d" "default" entry
     (file "~/Notes/templates/daily_template.org")
     :target (file+head "%<%Y-%m-%d>.org"
                        "#+title:\t%<%Y-%m-%d>\n#+\t"))))

(setq doom-theme 'doom-solarized-light)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  )

(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 10)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 16)
      ;; doom-variable-pitch-font (font-spec :family "CMU Serif" :size 12)
      )

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic)
  '(font-lock-variable-name-face :slant italic)
  )
