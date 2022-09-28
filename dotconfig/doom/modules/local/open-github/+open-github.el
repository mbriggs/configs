;;; modules/local/open-github/+open-github.el -*- lexical-binding: t; -*-

;;; open-on-github

;; based heavily on open-github-from-here
;; Copyright (C) 2013 by Yuki SHIBAZAKI

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(defun open-on-github ()
  (interactive)
  (if (mb/git-project-p)
    (let ((host (mb/git-host))
          (lines (mb/git-lines-query))
          (user-repo (mb/git-user-repo))
          (branch (mb/git-branch))
          (filename (mb/git-filename)))

      (browse-url (concat "https://" host "/" user-repo "/tree/" branch "/" filename lines))))
  (message "not in a git project"))

(defun mb/git-lines-query ()
  (cl-multiple-value-bind (start end) (mb/region-lines)
    (if start
      (let ((s (concat "#L" start)))
        (if end
          (concat s "..L" end)
          s))
      "")))

(defun mb/region-lines ()
  (cond
    ((use-region-p)
     (cl-values
       (number-to-string (line-number-at-pos (region-beginning)))
       (number-to-string (- (line-number-at-pos (region-end)) 1))))
    ((eq 1 (line-number-at-pos (point)))
     (cl-values nil nil))
    (t
      (cl-values (number-to-string (line-number-at-pos (point))) nil))))

(defun mb/git-project-p ()
  (string= (mb/exec "git rev-parse --is-inside-work-tree") "true"))

(defun mb/git-host ()
  (let ((host (mb/exec "git config --get hub.host")))
    (if (not (string= host ""))
      host
      "github.com")))

(defconst *origin-re-1* "[:/]\\([a-z]+\\)/\\([a-z\\.]+\\)\\(\\.git\\)$")
(defconst *origin-re-2* "[:/]\\([a-z]+\\)/\\([a-z\\.]+\\)$")

(defun mb/git-user-repo ()
  (let ((remote (mb/exec "git config --get remote.origin.url")))
    (if (or
          (string-match *origin-re-1* remote)
          (string-match *origin-re-2* remote))
      (concat (match-string 1 remote) "/" (match-string 2 remote))
      (error "could not parse user and repo out of %s" remote))))

(defun mb/git-branch ()
  (let ((ref (mb/exec "git symbolic-ref HEAD 2> /dev/null")))
    (if (string-match "refs/heads/\\(.*\\)$" ref)
      (match-string 1 ref)
      (error "could not parse branch from %s" ref))))

(defun mb/git-filename ()
  (let ((top (mb/exec "git rev-parse --show-toplevel"))
        (file (buffer-file-name)))
    (if (string-match (concat top "/\\(.*\\)$") file)
      (match-string 1 file)
      (error "could not parse filename from %s -- %s" top file))))
