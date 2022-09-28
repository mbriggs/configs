;;; modules/local/evil/config.el -*- lexical-binding: t; -*-


(map!
  :n "L" #'mb/end-of-line
  :n "H" #'mb/start-of-line
  :ni "C-j" #'mb/scroll-up-line
  :ni "C-k" #'mb/scroll-down-line

  :n "RET" #'mb/evil-n-ret

  :ni "M-k" #'sp-kill-sexp
  :ni "M-K" #'sp-splice-sexp

  ;; insert

  :i "M-<left>" #'mb/start-of-line
  :i "M-<right>" #'mb/end-of-line
  :i "M-<backspace>" #'mb/delete-whole-line
  :i "S-<return>" #'mb/open-line-above
  :i "M-/" #'mb/comment-or-uncomment-region-or-line
  :i "M-D" #'mb/duplicate-line-or-region

  :leader

  :desc "Previous Buffer" "/" #'mb/switch-to-previous-buffer
  (:prefix ("j" . "sexp")
    :desc "Backward Barf" "L" #'sp-backward-barf-sexp
    :desc "Backward Slurp" "H" #'sp-backward-slurp-sexp
    :desc "Forward Barf" "h" #'sp-forward-barf-sexp
    :desc "Forward Slurp" "l" #'sp-forward-slurp-sexp))

(defun mb/evil-n-ret ()
  (interactive)
  (evil-ex-nohighlight)
  (save-buffer)
  (+workspace/display))

(add-hook 'typescript-mode
          (lambda ()
            (format-all-mode)
            (add-to-list 'evil-embrace-evil-surround-keys ?`)))

(advice-add '+workspace:switch-next :after #'+workspace/display)
(advice-add '+workspace:switch-previous :after #'+workspace/display)
