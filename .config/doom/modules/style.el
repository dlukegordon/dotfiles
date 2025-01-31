;;; $DOOMDIR/modules/style.el -*- lexical-binding: t; -*-

;;;;;;;; General style
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq display-line-numbers-type t)
(setq emojify-display-style 'unicode)
(setq line-spacing 0.1)
(setq tab-width 4)
(setq mode-line-right-align-edge 'right-fringe)
(setq dired-free-space nil)
(after! vertico
  (setq vertico-count 33))
(after! org
  (custom-set-faces!
    `(org-block :background ,(doom-color 'bg))
    `(org-block-begin-line :background ,(doom-color 'bg))
    `(org-block-end-line :background ,(doom-color 'bg))))

;;;;;;;; Fonts
;; Set up fonts so that variable is bigger than fixed in mixed-pitch mode
;; (setq doom-font (font-spec :family "TX-02-Trial" :size +my/font-size :height 1.0))
(setq doom-font (font-spec :family "Roboto Mono" :size +my/font-size :height 1.0))
(setq doom-variable-pitch-font (font-spec :family "ETBembo" :height 1.25))
;; If we don't do the below custom-set-faces, for some reason the correct height of the variable
;; font will not be applied in mixed-pitch-mode.
(custom-set-faces!
  '(variable-pitch :family "ETBembo" :height 1.25))
(use-package mixed-pitch
  :config
  (setq mixed-pitch-set-height t))

;;;;;;;; Doom style
(setq doom-theme 'doom-dark+)
(setq +doom-dashboard-menu-sections '())
(setq doom-modeline-hud t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-persp-name t)
(setq doom-modeline-env-enable-go nil)

;;;;;;;; Modeline style for doom-dark+ theme
;; To improve the crappy default
(custom-set-faces!
  '(mode-line :background "#313131")
  '(mode-line-inactive :foreground "#777778" :background "#1c1c1c")
  '(mode-line-emphasis :foreground "#339cdb")
  '(doom-modeline-buffer-path :inherit mode-line-emphasis)
  '(doom-modeline-buffer-file :inherit mode-line-buffer-id)
  '(doom-modeline-project-dir :inherit (doom-modeline font-lock-string-face bold))
  '(doom-modeline-persp-name :inherit (doom-modeline font-lock-comment-face italic))
  '(doom-modeline-urgent :inherit (doom-modeline error))
  '(doom-modeline-warning :inherit (doom-modeline warning))
  '(doom-modeline-info :inherit (doom-modeline success)))

;;;;;;;; Vterm
;; Change background color
(add-hook! 'vterm-mode-hook
  (face-remap-add-relative 'solaire-default-face :background "#141414"))
;; Hack to fix vterm style not updating
(defun old-version-of-vterm--get-color (index &rest _args)
  "This is the old version before it was broken by commit
https://github.com/akermu/emacs-libvterm/commit/e96c53f5035c841b20937b65142498bd8e161a40.
Re-introducing the old version fixes auto-dim-other-buffers for vterm buffers."
  (cond
   ((and (>= index 0) (< index 16))
    (face-foreground
     (elt vterm-color-palette index)
     nil 'default))
   ((= index -11)
    (face-foreground 'vterm-color-underline nil 'default))
   ((= index -12)
    (face-background 'vterm-color-inverse-video nil 'default))
   (t
    nil)))
(advice-add 'vterm--get-color :override #'old-version-of-vterm--get-color)
