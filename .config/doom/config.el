;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;; OS-specific settings
(defvar +my/font-size nil)
(if (eq system-type 'darwin)
    (progn
      (after! lsp-mode
        (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\deps\\'")
        (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\ops-gcs\\'"))
      (setq +my/font-size 14))
  (progn
    (setq +my/font-size 21)))

;;;;;;;; Style
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq display-line-numbers-type t)
(setq doom-theme 'doom-dark+)
(setq emojify-display-style 'unicode)
(setq line-spacing 0.1)
(setq tab-width 4)
;; Set up fonts so that variable is bigger than fixed in mixed-pitch mode
;; (setq doom-font (font-spec :family "TX-02-Trial" :size +my/font-size :height 1.0))
(setq doom-font (font-spec :family "Roboto Mono" :size +my/font-size :height 1.0))
(setq doom-variable-pitch-font (font-spec :family "ETBembo" :height 1.25))
(setq +doom-dashboard-menu-sections '())
(use-package mixed-pitch
  :config
  (setq mixed-pitch-set-height t)
  (set-face-attribute 'variable-pitch nil :height 1.25))
;; Set some faces
(after! org
  (custom-set-faces!
    `(org-block :background ,(doom-color 'bg))
    `(org-block-begin-line :background ,(doom-color 'bg))
    `(org-block-end-line :background ,(doom-color 'bg))))
;; (after! org
;;   (let ((bg-color (nth 0 (alist-get 'bg doom-themes--colors))))
;;     (set-face-background 'org-block bg-color)
;;     (set-face-background 'org-block-begin-line bg-color)
;;     (set-face-background 'org-block-end-line bg-color)))

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
;; (after! doom-modeline
;;   (set-face-background 'mode-line "#313131")
;;   (set-face-foreground 'mode-line-inactive "#777778")
;;   (set-face-background 'mode-line-inactive "#1c1c1c")
;;   (set-face-foreground 'mode-line-emphasis "#339cdb")
;;   (set-face-attribute 'doom-modeline-buffer-path nil :inherit 'mode-line-emphasis)
;;   (set-face-attribute 'doom-modeline-buffer-file nil :inherit 'mode-line-buffer-id)
;;   (set-face-attribute 'doom-modeline-project-dir nil :inherit '(doom-modeline font-lock-string-face bold))
;;   (set-face-attribute 'doom-modeline-persp-name nil :inherit '(doom-modeline font-lock-comment-face italic))
;;   (set-face-attribute 'doom-modeline-urgent nil :inherit '(doom-modeline error))
;;   (set-face-attribute 'doom-modeline-warning nil :inherit '(doom-modeline warning))
;;   (set-face-attribute 'doom-modeline-info nil :inherit '(doom-modeline success)))

;;;;;;;; Garbage Collection
;; Set garbage collection threshold very high.
;; Maybe way too high but seems to make everything smooth, and it seems like gcmh auto
;; garbage collects when you go idle so it's ok.
(setq gcmh-high-cons-threshold #x40000000)
(setq gcmh-low-cons-threshold #x40000000)

;;;;;;;; Misc
(after! magit
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))
(setq evil-snipe-scope 'line)
(setq doom-modeline-hud t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-persp-name t)
(setq dired-free-space nil)
(setq pixel-scroll-precision-interpolate-page t)
(pixel-scroll-precision-mode 1)
(global-tree-sitter-mode 1)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(setq doom-modeline-env-enable-go nil)
(setq mode-line-right-align-edge 'right-fringe)
(setq warning-minimum-level :error)
(after! vertico
  (setq vertico-count 33))
(setq confirm-kill-emacs nil)

;;;;;;;; Lsp
(setq lsp-signature-auto-activate nil)
(setq lsp-rust-analyzer-cargo-watch-command "clippy")
(setq lsp-rust-analyzer-proc-macro-enable nil)
(setq lsp-rust-analyzer-experimental-proc-attr-macros nil)
(setq lsp-rust-analyzer-diagnostics-disabled ["macro-error"])
(add-hook! prog-mode #'flymake-mode)
(after! lsp-mode
  (setq lsp-diagnostics-provider :flymake))

;;;;;;;; Org
(setq org-directory "~/org/")
(after! org
  (setq org-startup-with-inline-images t)
  (setq +org-startup-with-animated-gifs t)
  (setq org-startup-with-latex-preview t)
  (setq org-hide-emphasis-markers t)
  (setq org-link-descriptive t)
  (setq org-pretty-entities t)
  (setq org-hidden-keywords t)
  (setq org-appear-autoemphasis t)
  (setq org-appear-autolinks t)
  (setq org-appear-autosubmarkers t)
  (setq org-appear-autoentities t)
  (setq org-appear-autokeywords t)
  (setq org-appear-inside-latex t)
  (setq org-modern-star nil))
(add-hook 'org-mode-hook
          (lambda ()
            (solaire-mode -1)
            (display-line-numbers-mode -1)
            (mixed-pitch-mode 1)
            (org-fragtog-mode 1)
            (org-appear-mode 1)
            (org-indent-mode -1)
            (org-modern-mode 1)))
(add-hook 'doom-docs-mode-hook
          (lambda ()
            (mixed-pitch-mode 1)))
;; (evil-set-initial-state 'org-mode 'insert)

;;;;;;;; Gptel
(setq
 gptel-model 'claude-3-sonnet-20240229
 gptel-backend (gptel-make-anthropic
                   "Claude"
                 :stream t :key (getenv "ANTHROPIC_API_KEY"))
 gptel-track-media t
 gptel-default-mode 'org-mode)
(add-hook 'gptel-post-response-functions #'font-lock-update)
(add-hook 'gptel-post-stream-hook #'font-lock-update)
;; (add-hook 'gptel-post-response-functions 'gptel-end-of-response)
;; (add-hook 'gptel-post-stream-hook 'gptel-auto-scroll)

;;;;;;;; Vterm
(setq vterm-timer-delay 0.02)
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
(after! vterm
  (map! :map vterm-mode-map :ni "s-v" #'vterm-yank))
;; Polysign in a vterm popup
(defun +my/polysign ()
  (interactive)
  (+vterm/toggle nil)
  (vterm-send-string "exec polysign\n"))

;;;;;;;; Functions for keybinds
(defun +my/evil-select-entire-buffer ()
  "Select the entire buffer in visual mode"
  (interactive)
  (evil-normal-state)
  (execute-kbd-macro (kbd "ggVG")))
(defun +my/evil-insert-end-of-buffer ()
  "Go to the end of the buffer and enter insert mode"
  (interactive)
  (evil-normal-state)
  (execute-kbd-macro (kbd "GA")))
(defun +my/force-save ()
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))

;;;;;;;; Hack to get live-previews when searching the project)
(defun +my/search-project (&optional arg)
  (interactive "P")
  (+default/search-project arg))

;;;;;;;; Better file finding with live previews
(defun +my/consult--file-preview ()
  "Create preview function for files."
  (let ((open (consult--temporary-files))
        (preview (consult--buffer-preview))
        (root (projectile-project-root)))
    (lambda (action cand)
      (unless cand
        (funcall open))
      (funcall preview action
               (and cand
                    (eq action 'preview)
                    (funcall open (expand-file-name cand root)))))))

(defun +my/consult-project-file-preview ()
  "Search for a file in the current project with live preview.
Uses projectile to get project files and consult for selection with preview."
  (interactive)
  (let ((project-root (projectile-project-root)))
    (unless project-root
      (user-error "Not in a project"))
    (find-file
     (projectile-expand-root
      (consult--read
       (projectile-project-files project-root)
       :prompt (format "[%s] Find file: " (projectile-project-name))
       :category 'file
       :sort nil
       :require-match t
       :state (+my/consult--file-preview))))))

;;;;;;;; Set up projectile and persp mode as a "sessionizer"
(defun +my/projectile-persp-switch-project ()
  "Switch to a projectile project, using persp-switch if already open."
  (interactive)
  (unless (bound-and-true-p persp-mode)
    (user-error "persp-mode is not enabled"))
  (let* ((project (projectile-completing-read
                   "Switch to project: "
                   (projectile-relevant-known-projects)))
         (workspace-name (file-name-nondirectory (directory-file-name project))))
    (if (persp-with-name-exists-p workspace-name)
        (persp-switch workspace-name)
      (projectile-switch-project-by-name project))))
(defun +my/projectile-persp-switch-last-project ()
  "Switch to the last projectile project"
  (interactive)
  (let ((project (car (projectile-relevant-open-projects))))
    (if project
        (let ((workspace-name (file-name-nondirectory (directory-file-name project))))
          (persp-switch workspace-name))
      (message "No last project found"))))
(projectile-mode 1)
(setq +workspaces-switch-project-function
      (lambda (&rest _)
        (require 'consult)
        (+my/consult-project-file-preview)))
(setq projectile-project-search-path '("~/scratch" "~/configs" "~/org" ("~/projects" . 1) ("~/gits" . 1) ("~/u410" . 1)))
(setq projectile-auto-discover t)
(setq projectile-enable-caching nil)
(setq projectile-track-known-projects-automatically nil)
(setq projectile-sort-order 'recently-active)
(after! treemacs
  (treemacs-follow-mode 1)
  (treemacs-project-follow-mode 1))

;;;;;;;; Keybindings
(map! "s-<left>" #'evil-window-left)
(map! "s-<down>" #'evil-window-down)
(map! "s-<up>" #'evil-window-up)
(map! "s-<right>" #'evil-window-right)
(map! "s-\\" #'evil-window-mru)
(map! "s-w" #'kill-current-buffer)
(map! "s-<return>" #'+vterm/toggle)
(map! :niv "s-<return>" #'+vterm/toggle) ;; For some reason we also need this for the binding to work on mac
(map! :n "-" #'dired-jump)
(map! :g "s-v" #'yank)
(map! :n "s-v" #'evil-paste-after)
(map! :i "s-v"
      (cmd! (evil-paste-before 1)
            (forward-char)))
(map! :ni "s-s" #'+my/force-save)
(map! :ni "s-a" #'+my/evil-select-entire-buffer)
(map! :ni "s-f" #'consult-line)
(map! :ni "s-q" #'save-buffers-kill-terminal)
(map! :n "C-\\" #'+my/evil-insert-end-of-buffer)
(map! :leader "\\" #'comment-line)
(map! :leader "/" #'+my/search-project)
(map! :leader "s p" #'+my/search-project)
(map! :leader "w v" #'+evil/window-vsplit-and-follow)
(map! :leader "w V" #'evil-window-vsplit)
(map! :leader "d" #'consult-flymake)
(map! :leader "g p" #'+my/polysign)
(map! :n "` \\" #'+evil/window-vsplit-and-follow)
(map! :n "` -" #'+evil/window-split-and-follow)
(map! :n "` k" #'evil-window-delete)
(after! projectile
  (map! :leader "SPC" #'+my/consult-project-file-preview)
  (map! :n "` o" #'+my/projectile-persp-switch-project)
  (map! :n "` SPC" #'+my/projectile-persp-switch-last-project)
  (map! :leader "p p" #'+my/projectile-persp-switch-project)
  (map! :leader "e" #'+my/projectile-persp-switch-project)
  (map! :leader "r" #'+my/projectile-persp-switch-last-project))
(after! dired
  (map! :map dired-mode-map :n "c" #'dired-create-empty-file)
  ;; Swap dired RET and a keys, so that RET opens and deletes dired buffer
  (map! :map dired-mode-map :n "RET" #'dired-find-alternate-file)
  (map! :map dired-mode-map :n "a"   #'dired-find-file))
(after! gptel
  (map! :leader "o l" #'gptel)
  (map! :nv "g l" #'gptel-add)
  (map! :nv "g L" #'gptel-rewrite))
