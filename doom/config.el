;; [[file:config.org::*Theme][Theme:1]]
(setq doom-theme 'doom-solarized-light)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
)
;; Theme:1 ends here

;; [[file:config.org::*Fonts][Fonts:1]]
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 12)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 12)
      doom-serif-font (font-spec :family "Iosevka Nerd Font" :size 12)
      doom-font-increment 1
      doom-big-font-increment 1)
;; Fonts:1 ends here

;; [[file:config.org::*Emacs options][Emacs options:1]]
(xterm-mouse-mode t) ;; enable mouse
(setq mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't
      scroll-preserve-screen-position t
      scroll-step 1)

(beacon-mode t)

(save-place-mode t)
(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t
      auto-save-default t)

(setq browse-url-generic-program "firefox"
      rainbow-mode t
      x-stretch-cursor t)

(setq calc-angle-mode 'rad
      calc-symbolic-mode t)

(setq confirm-kill-emacs nil)

(setq doom-scratch-initial-major-mode 'org-mode) ;; make scratch buffer be in org mode -> coding(with #+src) or notes
;; Emacs options:1 ends here

;; [[file:config.org::*Modeline][Modeline:1]]
(display-time-mode nil)
(display-battery-mode nil)
(setq doom-modeline-height 15
      doom-modeline-bar-width 5
      doom-modeline-persp-name t
      display-battery-mode nil
      display-time-mode nil)
;; Modeline:1 ends here

;; [[file:config.org::*editor options][editor options:1]]
(whitespace-mode t) ;; hl whitespace
(global-subword-mode t)
(+global-word-wrap-mode t)

(setq hscroll-margin 10
      scroll-margin 10
      display-line-numbers-type 'absolute)

(setq evil-ex-substitute-global t
      evil-move-cursor-back t
      evil-kill-on-visual-paste nil)

(setq evil-snipe-scope 'visible
      evil-snipe-auto-scroll t
      evil-snipe-repeat-keys t)

(setq yas-triggers-in-field t)

(setq +zen-text-scale 1)

(setq-default flycheck-indication-mode 'left-fringe)

(add-hook 'text-mode-hook 'visual-fill-column-mode)
(setq visual-fill-column-enable-sensible-window-split t
      visual-fill-column-center-text t
      visual-fill-column-width 120
      )

(setq company-idle-delay 0.1  ;; do not set to 0 -> massive performance issues
      company-show-numbers t
      company-minimum-prefix-length 2)

(setq which-key-idle-delay 0.1 ;; do not set to 0 -> massive performance issues
      undo-limit 80000000)

(setq standard-indent 8
      tab-width 8
      evil-shift-width 8
      indent-tabs-mode nil
)
(after! rustic
      rustic-indent-offset 8
      ) ;; configure for other languages if others used
;; editor options:1 ends here

;; [[file:config.org::*Windows & splits][Windows & splits:1]]
(setq evil-vsplit-window-right t
      even-window-sizes 'width-only
      right-fringe-width 10
      window-combination-resize t
      split-height-threshold nil
      split-width-threshold 0
      )
;; Windows & splits:1 ends here

;; [[file:config.org::*Counsel & Ivy][Counsel & Ivy:1]]
(ivy-posframe-mode t)
(setq ivy-posframe-display-functions-alist '((t . ivy-display-function-fallback)))
(setq ivy-posframe-height-alist '((t . 20)))
;; Counsel & Ivy:1 ends here

;; [[file:config.org::*Popup buffers][Popup buffers:1]]
;; modify defaults
(setq-default +popup-defaults
              '(:side 'right
                :width 0.25
                :select 'ignore
                :quit nil
                :ttl 5
                :modeline t))

(set-popup-rules!
  '(("\\*.*(?!Agenda).*\\*" ;; match all * buffers except Agenda (breaks it)
     :side right
     :width 0.25 ;;'+popup-shrink-to-fit
     :modeline t
     :quit nil)
    ))
;; Popup buffers:1 ends here

;; [[file:config.org::*leader system][leader system:1]]
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
               "D" 'dired-view-file)
      (:prefix "i"
               "d" 'user-insert-todays-date
               "D" 'user-insert-any-date)
      ;; remove unused from leader menu
      "'" nil
      "`" nil
      "." nil
      "," nil
      "SPC" nil
      "/" nil
      ":" nil)
;; leader system:1 ends here

;; [[file:config.org::*Global navigation][Global navigation:1]]
(map!
 :map  'override
 :nvimore "M-j" 'evil-window-left
 :nvimore "M-k" 'evil-window-right
 :nvimore "M-s" 'evil-window-vsplit
 :nvimore "M-q" (lambda () (interactive) (evil-quit) (balance-windows))
 :nvimore "M-x" 'dired-jump
 :nvimore "M-f" 'counsel-fzf
 :nvimore "M-r" 'counsel-recentf
 :nvimore "M-h" '+lookup/documentation
 :nvimore "M-t" 'shell-command ;; t for terminal
 :nvimore "M-'" 'consult-bookmark
 :nvimore "M-=" (lambda () (interactive) (evil-window-increase-width 10))
 :nvimore "M--" (lambda () (interactive) (evil-window-decrease-width 10))
 :nvimore "M-/" '+default/search-project
 :nvimore "M-;" 'counsel-M-x
 :nvimore "C-c" 'evil-force-normal-state ;; if all else fails (remap Alt_l: Esc)
 :nvimore "C--" 'doom/decrease-font-size
 :nvimore "C-=" 'doom/increase-font-size
 :nvimore "C-0" 'doom/reset-font-size)

(map!
 :map evil-org-agenda-mode-map
 :nvimore "M-j" 'evil-window-prev
 :nvimore "M-k" 'evil-window-next
 :nvimore "M-s" 'evil-window-vsplit
 :nvimore "M-q" 'user-window-quit)
;; Global navigation:1 ends here

;; [[file:config.org::*Vim editing][Vim editing:1]]
(setq evilem-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s)) ;; !! using dvorak keyboard layout.
(map!
 :nvmo "C-u"   'user-scroll-down-up-page
 :nvmo "C-d"   'user-scroll-down-half-page
 :nvmo "C-o"   (lambda () (interactive) (evil-jump-backward 1) (evil-scroll-line-to-center nil))
 :nvmo "C-i"   (lambda () (interactive) (evil-jump-forward 1) (evil-scroll-line-to-center nil))
 :nvmo "n"     (lambda () (interactive) (evil-ex-search-next 1) (evil-scroll-line-to-center nil))
 :nvmo "N"     (lambda () (interactive) (evil-ex-search-previous 1) (evil-scroll-line-to-center nil))
 :nvmo "U"     'evil-redo
 :nvmo "Q"     'evil-execute-last-recorded-macro
 :nvmo "j"     'evil-next-visual-line
 :nvmo "k"     'evil-previous-visual-line
 :nvmo "J"     'evilem-motion-next-line ;; evil-join -> "+"
 :nvmo "K"     'evilem-motion-previous-line ;; help under keyword -> Alt+h
 :nvmo "L"     'evil-end-of-line
 :nvmo "H"     'evil-first-non-blank
 :nvmo "+"     'evil-join)

(map!
 :map evil-snipe-local-mode-map
 :nm   "s"     'evilem-motion-find-char
 :nm   "S"     'evilem-motion-find-char-backward
 ;; in operator made no conflict with 'surround: s'
 :o    "z"     'evilem-motion-find-char
 :o    "Z"     'evilem-motion-find-char-backward)
;; Vim editing:1 ends here

;; [[file:config.org::*dired][dired:1]]
(map! :map dired-mode-map
      :n "RET" 'dired-open-file
      :n "j" 'evil-next-line
      :n "k" 'evil-previous-line
      :n "f" 'dired-goto-file
      :n "h" 'dired-up-directory
      :n "l" 'dired-open-file
      :n "m" 'dired-mark
      :n "t" 'dired-toggle-marks
      :n "u" 'dired-unmark
      :n "y" 'dired-do-copy
      :n "r" 'dired-do-rename
      :n "d" 'dired-do-delete
      :n "T" 'dired-do-touch
      :n "x" 'dired-do-chmod
      :n "w" 'dired-do-chown
      :n "p" 'dired-do-print
      :n "y" 'dired-copy-filenamecopy-filename-as-kill
      :n "z" 'dired-do-compress
      :n "." 'dired-omit-mode
      :n "o" 'user-dired-order
      :n "s" 'dired-toggle-sudo
      (:prefix ("+" . "create")
       :n "f" 'dired-create-empty-file
       :n "d" 'dired-create-directory
       ))

(map! :map peep-dired-mode-map
      :n "j" 'peep-dired-next-file
      :n "k" 'peep-dired-prev-file)

(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; dired:1 ends here

;; [[file:config.org::*org-mode][org-mode:1]]
(map!
 :map evil-org-mode-map
 :nvmo "L"     'evil-org-end-of-line
 :nvmo "H"     'evil-first-non-blank
 (:prefix "g"
  :n "j" 'org-next-visible-heading
  :n "k" 'org-previous-visible-heading))
;; org-mode:1 ends here

;; [[file:config.org::*Insert date's][Insert date's:1]]
(defun user-insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))

(defun user-insert-todays-date (prefix)
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%A, %B %d, %Y")
                 ((equal prefix '(4)) "%m-%d-%Y")
                 ((equal prefix '(16)) "%Y-%m-%d"))))
    (insert (format-time-string format))))
;; Insert date's:1 ends here

;; [[file:config.org::*Better PgUp/PgDn][Better PgUp/PgDn:1]]
(defun user-scroll-down-half-page ()
  "scroll down half a page while keeping the cursor centered"
  (interactive)
  (let ((ln (line-number-at-pos (point)))
    (lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) (move-to-window-line nil))
      ((= ln lmax) (recenter (window-end)))
      (t (progn
           (move-to-window-line -1)
           (recenter))))))

(defun user-scroll-up-half-page ()
  "scroll up half a page while keeping the cursor centered"
  (interactive)
  (let ((ln (line-number-at-pos (point)))
    (lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) nil)
      ((= ln lmax) (move-to-window-line nil))
      (t (progn
           (move-to-window-line 0)
           (recenter))))))
;; Better PgUp/PgDn:1 ends here

;; [[file:config.org::*Org keywords lowercase][Org keywords lowercase:1]]
(defun org-syntax-convert-keyword-case-to-lower ()
  "Convert all #+KEYWORDS to #+keywords."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((count 0)
          (case-fold-search nil))
      (while (re-search-forward "^[ \t]*#\\+[A-Z_]+" nil t)
        (unless (s-matches-p "RESULTS" (match-string 0))
          (replace-match (downcase (match-string 0)) t)
          (setq count (1+ count))))
      (message "Replaced %d occurances" count))))
;; Org keywords lowercase:1 ends here

;; [[file:config.org::*Dired][Dired:1]]
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
      global-auto-revert-non-file-buffers t
      )

(remove-hook 'dired-mode-hook #'all-the-icons-dired-mode) ;; icons are bloat and create mental overhead
;; Dired:1 ends here

;; [[file:config.org::*general options][general options:1]]
(setq org-modules '(ol-bibtex org-habit org-inlinetask org-tempo org-checklist org-collector org-toc org-velocity))
(after! org
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'org-superstar-mode)
  (add-hook 'org-mode-hook 'org-num-mode)
  (add-hook 'org-mode-hook 'org-appear-mode)

  (setq org-directory "~/Org"
        org-archive-location "~/Archive/Org/archive_%s::"
        org-use-property-inheritance t
        org-startup-with-inline-images t
        org-startup-indented t
        org-list-allow-alphabetical t
        org-tags-column 0
        org-fold-catch-invisible-edits 'smart
        org-export-headline-levels 5
        org-refile-use-outline-path 'file
        org-refile-allow-creating-parent-nodes 'confirm
        org-use-sub-superscripts '{}
        org-startup-with-inline-images t ; Display images  default.
        org-startup-with-latex-preview t ; Display equations by default.
        ))
;; general options:1 ends here

(setq org-babel-default-header-args
      '((:session . "none")
        (:results . "replace")
        (:exports . "code")
        (:cache . "no")
        (:noweb . "no")
        (:hlines . "no")
        (:tangle . "no")
        (:comments . "link")))

(setq   org-auto-tangle-default t
        org-src-window-setup 'current-window)

;; [[file:config.org::*log][log:1]]
(after! org
  (setq   org-log-done 'time
          org-log-repeat 'time
          org-log-into-drawer 'logbook)
  )
;; log:1 ends here

;; [[file:config.org::*priority][priority:1]]
(after! org
  (setq org-priority-highest ?1
        org-priority-lowest ?5
        org-priority-faces
        '((?1 . 'all-the-icons-red)
          (?2 . 'all-the-icons-orange)
          (?3 . 'all-the-icons-yellow)
          (?4 . 'all-the-icons-green)
          (?5 . 'all-the-icons-blue)))
  )
;; priority:1 ends here

;; [[file:config.org::*org agenda][org agenda:1]]
(after! org
  (setq org-agenda-files '("~/Org")
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
        org-deadline-warning-days 3))
;; org agenda:1 ends here

;; [[file:config.org::*clock][clock:1]]
(after! org
  (setq   org-clock-out-when-done t
          org-clock-persist t ;; Save the running clock and all clock history when exiting Emacs, load it on startup
          org-clock-into-drawer t))
;; clock:1 ends here

;; [[file:config.org::*org roam][org roam:1]]
(after! org
(setq   org-roam-directory "~/Notes"
        org-roam-dailies-directory "daily/" ;; relative to org roam-dir
        org-roam-completion-everywhere t
        org-auto-align-tags 0)
)
;; org roam:1 ends here

;; [[file:config.org::*Format org-buffers & symbols][Format org-buffers & symbols:1]]
(after! org
  (setq   org-pretty-entities t
          org-pretty-entities-include-sub-superscripts t
          org-ellipsis "..."
          org-num-max-level 3
          org-hide-leading-stars t
          org-appear-autoemphasis t
          org-appear-autosubmarkers t
          org-appear-autolinks nil
          org-hide-emphasis-markers t
          org-table-convert-region-max-lines 20000
          org-emphasis-alist
          '(("*" (bold))
            ("/" italic)
            ("_" underline)
            ("=" org-verbatim verbatim)
            ("~" org-code verbatim)
            ("+" (:strike-through t)))
          org-fontify-quote-and-verse-blocks t
          org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a."))
          org-superstar-headline-bullets-list '("◉" "●" "○" "◈" "◆" "◇" )
          org-superstar-prettify-item-bullets t
          org-superstar-item-bullet-alist '((?* . "•")
                                            (?- . "•")
                                            (?+ . "➤"))))
;; Format org-buffers & symbols:1 ends here

;; [[file:config.org::*Header styling][Header styling:1]]
(custom-set-faces!
  '(org-todo                :weight extra-bold :height 1.0)
  '(org-checkbox            :weight extra-bold :height 1.0)
  '(org-priority            :weight extra-bold :height 1.0)
  '(org-special-keyword     :weight normal     :height 1.0)
  '(org-drawer              :weight normal     :height 1.0)
  '(org-tag                 :weight normal     :height 1.0)
  '(org-date                :weight normal     :height 1.0)
  '(org-document-title      :weight ultra-bold :height 1.4)
  '(outline-1               :weight extra-bold :height 1.7)
  '(outline-2               :weight bold       :height 1.6)
  '(outline-3               :weight bold       :height 1.5)
  '(outline-4               :weight semi-bold  :height 1.4)
  '(outline-5               :weight semi-bold  :height 1.3)
  '(outline-6               :weight semi-bold  :height 1.2)
  '(outline-8               :weight semi-bold  :height 1.1)
  '(outline-9               :weight semi-bold  :height 1.0)
  '(org-level-1             :inherit outline-1 :height 1.0)
  '(org-level-2             :inherit outline-2 :height 1.0)
  '(org-level-3             :inherit outline-3 :height 1.0)
  '(org-level-4             :inherit outline-4 :height 1.0)
  '(org-level-5             :inherit outline-5 :height 1.0)
  '(org-level-6             :inherit outline-6 :height 1.0)
  '(org-level-7             :inherit outline-8 :height 1.0)
  '(org-level-8             :inherit outline-9 :height 1.0)
  '(markdown-header-face    :weight extra-bold :height 1.4)
  '(markd own-header-face-1  :weight extra-bold :height 1.3)
  '(markdown-header-face-2  :weight bold       :height 1.2)
  '(markdown-header-face-3  :weight bold       :height 1.1)
  '(markdown-header-face-4  :weight semi-bold  :height 1.1)
  '(markdown-header-face-5  :weight semi-bold  :height 1.1)
  '(markdown-header-face-6  :weight semi-bold  :height 1.1)
  '(markdown-header-face-7  :weight semi-bold  :height 1.1)
  '(markdown-header-face-8  :weight semi-bold  :height 1.1)
  )
;; Header styling:1 ends here

;; [[file:config.org::*Tags][Tags:1]]
(after! org
  (setq org-tag-alist '(("event" . ?e)
                        ("habit" . ?h)
                        ("write" . ?w)
                        ("read" . ?r)
                        ("study" . ?s))))
;; Tags:1 ends here

;; [[file:config.org::*Todo states][Todo states:1]]
(after! org
  (setq org-todo-keywords '((type
                             "TODO(t)"
                             "IPROG(i)"
                             "NEXT(n)"
                             "OPT(o)"
                             "REVIEW(r)"
                             "WAIT(w)"
                             "|"
                             "DONE(d!)"
                             "CANC(c@)"
                             "DELEG(d@)"
                             "ASSIGND(a@)"))))
;; Todo states:1 ends here

;; [[file:config.org::*capture templates][capture templates:1]]
(after! org
  (setq org-capture-templates
        '(("t" "TODO: personal"
           entry (file+headline "~/Org/personal_todo.org" "outstanding")
           "* TODO %? \n"
           :empty-lines 1)

          ("e" "EVENT: personal"
           entry (file+headline "~/Org/personal_agenda.org" "events")
           "* %? :EVENT: \nscheduled: %^T \n"
           :empty-lines 1)

          ("r" "EVENT(repeat): personal"
           entry (file+headline "~/Org/personal_agenda.org" "repeating")
           "* %? :EVENT: \nscheduled: %^T \n"
           :empty-lines 1)

          ("n" "NOTE: personal"
           entry (file "~/Org/personal_note.org")
           "* %?\n%U"
           :empty-lines 1)

          ("T" "TODO: work"
           entry (file+headline "~/Org/work_todo.org" "current")
           "* TODO %?\n"
           :empty-lines 1)

          ("E" "EVENT: work"
           entry (file+headline "~/Org/work_agenda.org" "events")
           "* %? :EVENT: \nscheduled: %^T \n"
           :empty-lines 1)

          ("R" "EVENT(repeat): work"
           entry (file+headline "~/Org/work_agenda.org" "repeating")
           "* %? :EVENT: \nscheduled: %^T \n"
           :empty-lines 1)

          ("N" "NOTE @work"
           entry (file "~/Org/work_note.org")
           "* %? \n%U"
           :empty-lines 1))))
;; capture templates:1 ends here

;; [[file:config.org::*daily notes (journaling)][daily notes (journaling):1]]
(after! org
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         (file "~/Notes/templates/daily_template.org")
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title:\t%<%Y-%m-%d>\n #+author:\tbo\n #+date:\t%<%Y-%m-%d>")))))
;; daily notes (journaling):1 ends here
