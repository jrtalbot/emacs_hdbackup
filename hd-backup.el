;; hd-backup.el --- Backup your computer on an external harddrive
;;
;; Author: jrtalbot <jrtalbot99@gmail.com>
;; Maintainer: jrtalbot <jrtalbot99@gmail.com>
;; Created: September 23, 2023
;; Modified: September 23, 2023
;; Version: 0.0.1
;; Homepage: https://github.com/jrtalbot/hd-backup
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;; Commentary: This program is meant to provide a way to backup your data on an external harddrive
;;
;; Code:

(defun hd-backup ()
  (interactive)
  (let ((default-directory "/sudo::"))
    (let ((process (start-process "backup" "*backup*" "rsync" "-arvup" "--files-from=/home/jrtalbot/rsync.txt" "/home/jrtalbot/" "/media/jrtalbot/BACKUP")))
    (display-buffer "*backup*")
    (set-process-sentinel process 'backup-sentinel))
  )
)

(defun backup-sentinel (p e)
  (when (= 0 (process-exit-status p))
    (start-process "eject" "*backup*" "eject" "/media/jrtalbot/BACKUP")
    (message "%s" "Backed up!"))
)

(provide 'hd-backup)

;;; hd-backup.el ends here
