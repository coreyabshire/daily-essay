;;; daily-essay.el --- Corey's daily essay convenience functions.

;; Keywords: daily, essay, journal

;; daily-essay.el is Copyright (C) 2012 Corey Abshire. All Rights Reserved.
;;
;; It is free software; you can redistribute it and/or modify it under the
;; terms of either:
;;
;; a) the GNU General Public License as published by the Free Software
;; Foundation; either version 1, or (at your option) any later version, or
;;
;; b) the "Artistic License".

;;; Commentary:

;; Provides convenience functions related to creating a daily
;; essay. The primary one being at this point a function that does the
;; following.
;; 
;;  1) Ensure that a directory exists in some base path, wherein the
;;  name of the directory is date stamped with today's date.
;;
;;  2) Ensure a copy of some template file exists in that directory.
;;
;;  3) Opens that file as a buffer for editing, and that the point is
;;  positioned at the appropriate location to begin editing.
;;
;; You may wish to require this module as part of your .emacs file and
;; map some global key to it. I have mine mapped to (kbd "M-g d").
;;
;; I created this file as a convenience after a few days of getting
;; into a habit of writing an essay every day. I was looking to
;; increase my proficiency in both writing and in TeX and so decided
;; forcing myself to practice daily was the best way to do that. But
;; that didn't mean I had to endure all the overhead of creating the
;; directory and such every day to do so.

;;; Code:


;;; TODO: clean this up and make it customizable
(setq daily-essay-base-path "~/Dropbox/Essays")
(setq daily-essay-template-name
      (format "%s/%s" daily-essay-base-path "daily_template.tex"))

;;; TODO: consider renaming or moving this function 
;;;       name should match module namespace, or 
;;;       figure out what to do with generic functions like this
(defun date-stamp-today ()
  (let ((date (decode-time (current-time))))
    (let ((d (nth 3 date))
	  (m (nth 4 date))
	  (y (nth 5 date)))
      (format "%04d-%02d-%02d" y m d))))

(defun daily-essay-today-base ()
  (format "daily_%s" (date-stamp-today)))

(defun daily-essay-ensure-directory ()
  (let ((dir-name (format "%s/%s"
			  daily-essay-base-path
			  (daily-essay-today-base))))
    (if (file-exists-p dir-name)
	(if (file-directory-p dir-name)
	    dir-name
	  (error "File exists with same name as target directory."))
      (make-directory dir-name)
      dir-name)))

(defun daily-essay-start-today ()
  "Prepares and begins a session to write a daily essay."
  (interactive)
  (let* ((dir-name (daily-essay-ensure-directory))
	 (new-name (format "%s/%s.tex" dir-name (daily-essay-today-base))))
    (unless (file-exists-p new-name)
      (copy-file daily-essay-template-name new-name))
    (find-file new-name)
    (search-forward "maketitle")
    (dotimes (i 2) (forward-line))
    (message "Think. Write. Repeat.")))

(provide 'daily-essay)

