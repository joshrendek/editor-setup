(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (vkill exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; terminals are annoying sometimes, this fixes the blue screen of death background
;; color that atom-one-dark has in iTerm
;; THIS NEEDS TO BE AT THE TOP before packages and themes are required/loaded
;; if you use emacs in a regular window system the colors will work fine and be pretty
(if (not window-system)
    (defvar atom-one-dark-colors-alist
      '(("atom-one-dark-accent"   . "#528BFF")
        ("atom-one-dark-fg"       . "#ABB2BF")
        ("atom-one-dark-bg"       . "gray14")
        ("atom-one-dark-bg-1"     . "gray13")
        ("atom-one-dark-bg-hl"    . "gray13")
        ("atom-one-dark-gutter"   . "#666D7A")
        ("atom-one-dark-accent"   . "#AEB9F5")
        ("atom-one-dark-mono-1"   . "#ABB2BF")
        ("atom-one-dark-mono-2"   . "#828997")
        ("atom-one-dark-mono-3"   . "#5C6370")
        ("atom-one-dark-cyan"     . "#56B6C2")
        ("atom-one-dark-blue"     . "#61AFEF")
        ("atom-one-dark-purple"   . "#C678DD")
        ("atom-one-dark-green"    . "#98C379")
        ("atom-one-dark-red-1"    . "#E06C75")
        ("atom-one-dark-red-2"    . "#BE5046")
        ("atom-one-dark-orange-1" . "#D19A66")
        ("atom-one-dark-orange-2" . "#E5C07B")
        ("atom-one-dark-gray"     . "#3E4451")
        ("atom-one-dark-silver"   . "#AAAAAA")
        ("atom-one-dark-black"    . "#0F1011"))
      "List of Atom One Dark colors.")
  )


(defvar my-packages '(
                      ;; -- enable vim keybindings in emacs
                      evil
                      ;; -- enable powerline customized status bar
                      powerline
                      ;; -- install atom one dark theme
                      atom-one-dark-theme
                      ;; -- remove whitespace in buffers
                      whitespace-cleanup-mode
                      ;; -- popup buffer switcher
                      popup-switcher
                      ;; -- copy-paste integration with system clipboard
                      pbcopy
                      ;; ### LANGUAGE SPECIFIC PLUGINS ###
                      ;; ## GOLANG ##
                      ;; -- language mode
                      go-mode
                      ;; -- autocomplete
                      go-autocomplete
                      ;; -- Style guidelines for go, could add to after save hook
                      golint
                      ;; -- test helpers for running go tests
                      gotest
                      ;; -- add go documentation to the status eldoc area buffer below powerline
                      go-eldoc

                      ;; -- automatically open/close parens
                      smartparens

                      ;; ## JSON ##
                      json-mode

                      ;; ## ANSIBLE ##
                      ansible

                      ;; ## LISP
                      lsp-mode

                      ;; ## DOCKERFILES ##
                      dockerfile-mode

                      ;; ## NGINX CONFIGS
                      nginx-mode

                      ;; ## RUBY & RAILS
                      ;; -- coffescript language support
                      coffee-mode
                      ;; -- haml template support
                      haml-mode
                      ;; -- test mode with rspec
                      rspec-mode
                      ;; -- linter for ruby
                      rubocop
                      ;; -- helpful ruby transformations
                      ruby-tools ;; https://github.com/rejeep/ruby-tools.el
                      ;; -- ruby version manager
                      rvm

                      ;; ## LOGSTASH CONFIGS
                      logstash-conf

                      ;; ## TERRAFORM CONFIGS
                      terraform-mode

                      ;; ## YAML FILES
                      yaml-mode

                      ;; ## MARKDOWN FILES
                      markdown-mode
                      ))

;; go through every package we listed and install it if its not installed
(dolist (p my-packages)
  (when (not(package-installed-p p))
    (package-install p)))

;; make sure all our packages are required so they work!
(dolist (p my-packages)
  (
   require (intern-soft p)))

;; enable VIM keybindings
(evil-mode 1)

;; We use zsh, so lets make sure its set as our shell
(setq shell-file-name "zsh")
(setq shell-command-switch "-c")

;; powerline statusbar on the bottom of the editor
(powerline-vim-theme)

;; enable projectile everywhere - project management system
;; see http://batsov.com/projectile/ for more details
;; example for searching files: C-c pf
(projectile-global-mode)
;; grizzle provides a buffered pane/list of files instead of default
;; ido status-bar style list of files
(setq projectile-completion-system 'grizzl)

;; show line numbers
(global-linum-mode 1)

;; add themes folder to load path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; load the atom-one-dark theme
(load-theme 'atom-one-dark t)

;; enable whitespace cleanup in all buffers
;; this will remove un-needed whitespace at the end of lines/code blocks
(whitespace-cleanup-mode)

;; enable smart parens globally, this adds matching parens
;; when you open them 
(smartparens-global-mode)

;; improve redraw performance of emacs
;; see http://lists.gnu.org/archive/html/emacs-devel/2011-09/msg00350.html
;; for more information
(setq redisplay-dont-pause t)

;; ########################
;; KEY SHORTCUTS
;; ########################
(global-set-key (kbd "C-c ,p") 'insert-pry-expression)
;; magit for git management in emacs
(global-set-key (kbd "C-c ,mg") 'magit-status)
;; popup for buffer switching
(global-set-key (kbd "C-c ,b") 'psw-switch-buffer)


;; ########################
;; MODE SPECIFIC KEY SHORTCUTS
;; Define functions so we can hook them on the language when its in the
;; appropriate mode down in *LANGUAGE SPECIFIC HOOKS*
;; ########################
(defun setup-go-jumps() (global-set-key (kbd "C-c ,g") 'godef-jump))
(defun setup-go-tests() (global-set-key (kbd "C-c ,r") 'go-test-current-test))

;; ########################
;; LANGUAGE SPECIFIC HOOKS
;; ########################
(defun my-go-setup()
  ;; Use goimports on save
  (setq gofmt-command "goimports")
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; load mode specific key shortcuts
  (add-hook 'go-mode-hook 'setup-go-jumps)
  (add-hook 'go-mode-hook 'setup-go-tests)
  )

;; run our hook in go mode
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook 'my-go-setup)

;; Enable go auto-completion using go-nsf and auto-complete
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;; make sure GOPATH is loaded properly on mac
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;; hide toolbars up top, more real-estate on screen
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -99))

;; macro to insert binding pry for ruby debugging
(defun insert-pry-expression()
  "Insert require 'pry'; binding.pry at cursor point"
  (interactive)
  (insert "binding.pry")
  )

(provide 'custom)
;; ENDS HERE
