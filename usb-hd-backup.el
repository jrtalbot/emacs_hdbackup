;; usb-hd-backup.el --- Backup your computer on an external hard drive via USB
;;
;; Author: jrtalbot <jrtalbot99@gmail.com>
;; Maintainer: jrtalbot <jrtalbot99@gmail.com>
;; Created: September 23, 2023
;; Modified: September 23, 2023
;; Version: 0.0.1
;; Homepage: https://github.com/jrtalbot/usb-hd-backup
;;
;; This file is not part of GNU Emacs.

;;; Commentary:

;; This recipe provides a way to backup your data on an external hard drive via USB.

;;; Code:
(defun usb-hd-backup ()
  "Backup to an external hard drive via USB."
  (interactive)
  (let ((default-directory "/sudo::"))
    (let ((process (start-process "backup" "*backup*" "rsync" "-arvup" "--files-from=/home/jrtalbot/rsync.txt" "/home/jrtalbot/" "/media/jrtalbot/BACKUP")))
      (display-buffer "*backup*")
      (set-process-sentinel process 'backup-sentinel))
    )
  )

(defun backup-sentinel (p)
  "Waits for backup process P to finish then ejects the hard drive."
  (when (= 0 (process-exit-status p))
    (start-process "eject" "*backup*" "eject" "/media/jrtalbot/BACKUP")
    (message "%s" "Backed up!"))
  )

(provide 'usb-hd-backup)

;;; usb-hd-backup.el ends here
