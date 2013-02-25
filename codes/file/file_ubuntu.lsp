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

;; copy the src folder to dest/src recursively
;; both src and dest must be existing folders, otherwise an exception will be thrown out
;; it doesn't matter whether src and dest arguments are ended with / or not
;; note, if there is a folder which has the same name as src, the copy still work
(define (copy-folder src dest)
  (unless (file? src) (throw-error (append "src folder doesn't exist, src:" src)))
  (unless (directory? src) (throw-error (append "src is not a directory, src:" src)))
  (unless (file? dest) (throw-error (append "dest folder doesn't exist, dest:" dest)))
  (unless (directory? dest) (throw-error (append "dest is not a directory, dest:" dest)))
  (exec (append "cp -r " src " " dest))
  )
