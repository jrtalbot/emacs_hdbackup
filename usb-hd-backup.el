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
;;
;; This program is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation, either version 3 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
;; You should have received a copy of the GNU General Public License along with
;; this program. If not, see <https://www.gnu.org/licenses/>.

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
