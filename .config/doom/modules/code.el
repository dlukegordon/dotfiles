;;; $DOOMDIR/modules/code.el -*- lexical-binding: t; -*-

;;;;;;;; Lsp
(setq lsp-signature-auto-activate nil)
(setq lsp-rust-analyzer-cargo-watch-command "clippy")
(setq lsp-rust-analyzer-proc-macro-enable nil)
(setq lsp-rust-analyzer-experimental-proc-attr-macros nil)
(setq lsp-rust-analyzer-diagnostics-disabled ["macro-error"])
(add-hook! prog-mode #'flymake-mode)
(after! lsp-mode
  (setq lsp-diagnostics-provider :flymake))

;; Nix setup
;; (let ((username (user-login-name))
;;       (hostname (system-name)))
;;   (setq
;;    lsp-nix-nixd-server-path "nixd"
;;    lsp-nix-nixd-formatting-command ["alejandra"]
;;    lsp-nix-nixd-nixpkgs-expr "import <nixpkgs> { }"
;;    lsp-nix-nixd-nixos-options-expr
;;    (format "(builtins.getFlake \"/home/%s/dotfiles/nixos\").nixosConfigurations.%s.options"
;;            username hostname)
;;    lsp-nix-nixd-home-manager-options-expr
;;    (format "(builtins.getFlake \"/home/%s/dotfiles/nixos\").homeConfigurations.\"%s@%s\".options"
;;            username username hostname)))

;;;;;;;; Formatting
(after! apheleia
  (setq
   apheleia-formatters
   (append '((alejandra "alejandra"))
           apheleia-formatters)
   apheleia-mode-alist
   (cons '(nix-mode . alejandra)
         (assq-delete-all 'nix-mode apheleia-mode-alist))))
