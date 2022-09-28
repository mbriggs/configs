;;; term/vterm+/config.el -*- lexical-binding: t; -*-

(map!
 (:map vterm-mode-map
   :n "q" #'kill-buffer-and-window
   :ni "M-w" #'other-window))
