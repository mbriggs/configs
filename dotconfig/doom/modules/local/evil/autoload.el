;;; modules/local/evil/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun mb/screenshot ()
  "Save a screenshot of the current frame as an SVG image.
Saves to a temp file and puts the filename in the kill ring."
  (interactive)
  (let* ((filename (make-temp-file "Emacs" nil ".svg"))
         (data (x-export-frames nil 'svg)))
    (with-temp-file filename
      (insert data))
    (kill-new filename)
    (message filename)))

;;;###autoload
(defun mb/switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;;;###autoload
(defun mb/delete-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file, even the last one"
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines)
      (let ((trailnewlines (abs (skip-chars-backward "\n\t"))))
        (if (> trailnewlines 0)
          (progn
            (delete-char trailnewlines)))))))

;;;###autoload
(defun mb/scroll-down-line ()
  (interactive)
  (dotimes (i 3)
    (scroll-down-line)))

;;;###autoload
(defun mb/scroll-up-line ()
  (interactive)
  (dotimes (i 3)
    (scroll-up-line)))

;;;###autoload
(defun mb/line-beginning-text-position ()
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward " \t")
    (point)))

;;;###autoload
(defun mb/end-of-previous-word ()
  (save-excursion
    (forward-word -1)
    (forward-word)
    (point)))

;;;###autoload
(defun mb/start-of-next-word ()
  (save-excursion
    (forward-word)
    (forward-word -1)
    (point)))

;;;###autoload
(defun mb/pos-eol ()
  (save-excursion
    (end-of-line)
    (point)))

;;;###autoload
(defun mb/pos-bol ()
  (save-excursion
    (beginning-of-line)
    (point)))

;;;###autoload
(defun mb/comment-or-uncomment-region-or-line ()
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (progn
      (comment-or-uncomment-region (mb/pos-bol) (mb/pos-eol))
      (forward-line))))

;;;###autoload
(defun mb/quit ()
  (interactive)
  (if (window-minibuffer-p)
      (minibuffer-keyboard-quit)
    (keyboard-quit)))

;;;###autoload
(defun mb/rename-this-file-and-buffer ()
  (interactive)
  (let ((new-name (read-string "new name: "))
        (name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "buffer '%s' is not visiting a file!" name))
    (if (get-buffer new-name)
        (message "a buffer named '%s' already exists!" new-name)
      (progn
        (rename-file name new-name 1)
        (rename-buffer new-name)
        (set-visited-file-name new-name)
        (set-buffer-modified-p nil)))))

;;;###autoload
(defun mb/delete-this-buffer-and-file ()
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "file '%s' successfully removed" filename)))))


;;;###autoload
(defun mb/backwards-word ()
  (interactive "^")
  (let ((end-of-previous-word (mb/end-of-previous-word)))
    (cond
     ((eq (mb/pos-bol) (point))
      (forward-line -1)
      (end-of-line))
     ((< end-of-previous-word (mb/pos-bol))
      (beginning-of-line))
     ((< (point) end-of-previous-word)
      (forward-word -1))
     ((eq (point) end-of-previous-word)
      (forward-word -1))
     (t
      (goto-char end-of-previous-word)))))

;;;###autoload
(defun mb/forward-word ()
  (interactive "^")
  (let ((start-of-next-word (mb/start-of-next-word)))
    (cond
     ((eq (mb/pos-eol) (point))
      (forward-line)
      (beginning-of-line))
     ((> start-of-next-word (mb/pos-eol))
      (end-of-line))
     ((> (point) start-of-next-word)
      (forward-word 1))
     ((eq (point) start-of-next-word)
      (forward-word 1))
     (t
      (goto-char start-of-next-word)))))

;;;###autoload
(defun mb/duplicate-line-or-region ()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (let ((deactivate-mark) ; keep the region around after dupe
              (start (region-beginning))
              (end (region-end)))
          (goto-char end)
          (insert (buffer-substring start end)))

                                        ; no region, dupe line
      (let ((line (buffer-substring (point-at-bol)
                                    (point-at-eol))))
        (end-of-line)
        (newline)
        (insert line)))))


;;;###autoload
(defun mb/join-line ()
  "join the current and next lines, with one space in between them"
  (interactive)
  (save-excursion
    (forward-line 1)
    (beginning-of-line)
    (delete-char -1)
    (just-one-space)))

;;;###autoload
(defun mb/backward-delete-word ()
  "delete by word"
  (interactive)
  (let ((start (point)))
    (mb/backwards-word)
    (delete-region start (point))))

;;;###autoload
(defun mb/delete-word ()
  (interactive)
  (let ((start (point)))
    (forward-word 1)
    (delete-region start (point))))

;;;###autoload
(defun mb/end-of-line ()
  (interactive "^")
  (end-of-line))

;;;###autoload
(defun mb/start-of-line ()
  (interactive "^")

  (if (eq (mb/line-beginning-text-position) (point))
      (beginning-of-line)
    (beginning-of-line-text)))

;;;###autoload
(defun mb/open-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;;###autoload
(defun mb/open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (forward-line -1)
  (indent-for-tab-command))

;;;###autoload
(defun mb/delete-whole-line ()
  (interactive)
  (delete-region (line-beginning-position)
                 (line-end-position))

  (if (eq (point) (point-min))
      (progn
        (forward-line 1)
        (delete-char -1))
    (progn
      (delete-char -1)
      (forward-line 1)))
  (beginning-of-line))

;;;###autoload
(defun mb/copy-line-or-region ()
  (interactive)
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (kill-ring-save (line-beginning-position) (line-end-position))))

;;;###autoload
(defun mb/cut-line-or-region ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (kill-whole-line)))
