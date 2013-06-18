;; file_ubuntu.lsp
(context 'file)


;; get the file name without path
(define (file-name file-path)
  (unless (file? file-path) (throw-error (append "file doesn't exist, file-path:" file-path)))
  (if (directory? file-path) (throw-error (append "full-path can't be a folder path, file-path:" file-path)))
  (first (regex "[^/]*$" file-path))
  )

(define (remove-last-seperator path)
  (if (ends-with path "/")
      (replace "/$" path "" 0)
      path)
  )


;; get the folder name without path
(define (folder-name folder-path)
  (unless (file? folder-path) (throw-error (append "folder doesn't exist, folder-path:" folder-path)))
  (unless (directory? folder-path) (throw-error (append "argument must be a folder path, folder-path:" folder-path)))
  (first (regex "[^/]*$" (remove-last-seperator folder-path)))
  )

;; copy the src folder to dst/src recursively
;; both src and dst must be existing folders, otherwise an exception will be thrown out
;; it doesn't matter whether src and dst arguments are ended with / or not
;; if dst/src does exist before copying, it will be removed first
(define (copy-folder src dst)
  (unless (file? src) (throw-error (append "src folder doesn't exist, src:" src)))
  (unless (directory? src) (throw-error (append "src is not a directory, src:" src)))
  (unless (file? dst) (throw-error (append "dst folder doesn't exist, dst:" dst)))
  (unless (directory? dst) (throw-error (append "dst is not a directory, dst:" dst)))
  (let (d (append dst "/" (folder-name src)))
    (if (file? d)
	(remove-folder d))
    )
  (exec (append "cp -r " src " " dst))
  )

(define (create-link src dst)
  (if (file? dst) (rm dst)
      (exec (append "ln -s " src " " dst))))

(define (remove-folder dst)
  (unless (file? dst) (throw-error (append "dst folder doesn't exist, dst:" dst)))
  (unless (directory? dst) (throw-error (append "dst is not a directory, dst:" dst)))
  (exec (append "rm -rf " dst))
  )
