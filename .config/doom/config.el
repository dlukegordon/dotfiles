;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;;;;;; OS-specific settings
(defvar +my/font-size nil)

(let ((hostname (system-name)))
  (cond
   ((string-equal hostname "asgard")
    (setq +my/font-size 25)
    (ultra-scroll-mode 1))

   ((string-equal hostname "valhalla")
    (setq +my/font-size 20)
    (pixel-scroll-precision-mode 1))))

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
(setq pixel-scroll-precision-interpolate-page t)
(global-tree-sitter-mode 1)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(setq warning-minimum-level :error)
(setq confirm-kill-emacs nil)
(setq vterm-timer-delay 0.02)

;; Treesit-auto
;; (use-package treesit-auto
;;   :custom
;;   (treesit-auto-install 'prompt)
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode))

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

(load! "modules/style.el")
(load! "modules/org.el")
(load! "modules/code.el")
(load! "modules/projectile.el")
(load! "modules/bindings.el")
