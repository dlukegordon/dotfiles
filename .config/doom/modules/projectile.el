;;; $DOOMDIR/modules/projectile.el -*- lexical-binding: t; -*-

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
(setq projectile-project-search-path '("~/scratch" "~/dotfiles" "~/org" ("~/projects" . 1) ("~/gits" . 1) ("~/u410" . 1)))
(setq projectile-auto-discover t)
(setq projectile-enable-caching nil)
(setq projectile-track-known-projects-automatically nil)
(setq projectile-sort-order 'recently-active)
(after! treemacs
  (treemacs-follow-mode 1)
  (treemacs-project-follow-mode 1))
