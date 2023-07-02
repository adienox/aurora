(setq avy-all-windows t)

(map! :nvm "H" #'beginning-of-line-text
      :nvm "L" #'end-of-line)

(setq display-line-numbers-type 'relative)

(setq user-full-name "Adienox"
      user-mail-address "adwaitadk@pm.me")

(beacon-mode 1)

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump))

(map! :leader
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

(setq peep-dired-cleanup-on-disable t)

(setq doom-theme 'catppuccin)

(map! :leader
      (:prefix ("e" . "elfeed")
       :desc "Open Elfeed" "e" #'elfeed
       :desc "Update all feeds" "u" #'elfeed-update
       :desc "Open feed in browser" "b" #'elfeed-search-browse-url))

(use-package! elfeed-tube
  :after elfeed
  :demand t
  :config
  (setq elfeed-tube-auto-fetch-p t)
  (elfeed-tube-setup)
  :bind (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)
         :map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)))

(use-package! elfeed-tube-mpv
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))

(setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Readex Pro" :size 16)
      doom-big-font (font-spec :family "JetBrains Mono Nerd Font" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
      org-sueprstar-headline-itembullet '((?+ . ?➤) (?- . ?✦))) ; changes +/- symbols in item lists

(setq org-directory "~/Documents/org/")

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

(use-package! org-auto-tangle
:defer t
:hook (org-mode . org-auto-tangle-mode)
:config
(setq org-auto-tangle-default t))

;; (define-globalized-minor-mode global-rainbow-mode rainbow-mode
;;   (lambda ()
;;     (when (not (memq major-mode
;;                 (list 'org-agenda-mode)))
;;      (rainbow-mode 1))))
;; (global-rainbow-mode 1 )
