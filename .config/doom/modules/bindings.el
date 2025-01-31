;;; $DOOMDIR/modules/bindings.el -*- lexical-binding: t; -*-

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
  "Save even if unmodified, so ie formatting will run"
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))
(defun +my/polysign ()
  "Polysign in a vterm popup"
  (interactive)
  (+vterm/toggle nil)
  (vterm-send-string "exec polysign\n"))

;;;;;;;; General keybindings
(map! "s-<left>" #'evil-window-left)
(map! "s-<down>" #'evil-window-down)
(map! "s-<up>" #'evil-window-up)
(map! "s-<right>" #'evil-window-right)
(map! "s-\\" #'evil-window-mru)
(map! "s-w" #'kill-current-buffer)
(map! "s-<return>" #'+vterm/toggle)
;; For some reason we also need this for the binding to work on mac
(map! :niv "s-<return>" #'+vterm/toggle)
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

;;;;;;;; Projectile
(after! projectile
  (map! :leader "SPC" #'+my/consult-project-file-preview)
  (map! :n "` o" #'+my/projectile-persp-switch-project)
  (map! :n "` SPC" #'+my/projectile-persp-switch-last-project)
  (map! :leader "p p" #'+my/projectile-persp-switch-project)
  (map! :leader "e" #'+my/projectile-persp-switch-project)
  (map! :leader "r" #'+my/projectile-persp-switch-last-project))

;;;;;;;; Dired
(after! dired
  (map! :map dired-mode-map :n "c" #'dired-create-empty-file)
  ;; Swap dired RET and a keys, so that RET opens and deletes dired buffer
  (map! :map dired-mode-map :n "RET" #'dired-find-alternate-file)
  (map! :map dired-mode-map :n "a"   #'dired-find-file))

;;;;;;;; Gptel
(after! gptel
  (map! :leader "o l" #'gptel)
  (map! :nv "g l" #'gptel-add)
  (map! :nv "g L" #'gptel-rewrite))

;;;;;;;; Vterm
(after! vterm
  (map! :map vterm-mode-map :ni "s-v" #'vterm-yank))

;;;;;;;; Flymake
(map! :leader "j d" #'flymake-goto-next-error)
(map! :leader "k d" #'flymake-goto-prev-error)

;;;;;;;; Avy
(map!
 :leader "j j"
 (lambda ()
   (interactive)
   (evil-avy-goto-char-timer)))
(map!
 :leader "k k"
 (lambda ()
   (interactive)
   (evil-avy-goto-word-0)))
(map!
 :leader "j s"
 (lambda ()
   (interactive)
   (evil-avy-goto-char-2 1)))
(map!
 :leader "k s"
 (lambda ()
   (interactive)
   (evil-avy-goto-char-2 -1)))

;;;;;;;; evil-textobj-tree-sitter

;; Function
(define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
(define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
(map!
 :leader "j f"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "function.outer")))
(map!
 :leader "j F"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "function.inner" nil 1)))
(map!
 :leader "k f"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "function.outer" 1)))
(map!
 :leader "k F"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "function.inner" 1)))

;; Conditional
(define-key evil-outer-text-objects-map "v" (evil-textobj-tree-sitter-get-textobj "conditional.outer"))
(define-key evil-inner-text-objects-map "v" (evil-textobj-tree-sitter-get-textobj "conditional.inner"))
(map!
 :leader "j c"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "conditional.outer")))
(map!
 :leader "j C"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "conditional.inner" nil 1)))
(map!
 :leader "k c"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "conditional.outer" 1)))
(map!
 :leader "k C"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "conditional.inner" 1)))

;; Parameter
(define-key evil-outer-text-objects-map "p" (evil-textobj-tree-sitter-get-textobj "parameter.outer"))
(define-key evil-inner-text-objects-map "p" (evil-textobj-tree-sitter-get-textobj "parameter.inner"))
(map!
 :leader "j p"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "parameter.inner")))
(map!
 :leader "k p"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "parameter.inner" 1)))

;; Loop
(define-key evil-outer-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj "loop.outer"))
(define-key evil-inner-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj "loop.inner"))
(map!
 :leader "j l"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "loop.outer")))
(map!
 :leader "j L"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "loop.inner" nil 1)))
(map!
 :leader "k l"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "loop.outer" 1)))
(map!
 :leader "k L"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "loop.inner" 1)))

;; Assignment
(define-key evil-outer-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "assignment.outer"))
(define-key evil-inner-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "assignment.inner"))
(map!
 :leader "j a"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "assignment.inner")))
(map!
 :leader "k a"
 (lambda ()
   (interactive)
   (evil-textobj-tree-sitter-goto-textobj "assignment.inner" 1)))
