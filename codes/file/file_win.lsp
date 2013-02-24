;; file_win.lsp
(context 'file)

;; get the file name without path
(define (file-name file-full-path)
  (unless (file? file-full-path) (throw-error (append "file doesn't exist, file-full-path:" file-full-path)))
  (if (directory? file-full-path) (throw-error (append "file-full-path can't be a folder path, file-full-path:" file-full-path)))
  (first (regex "[^\\\\]*$" file-full-path))
)

;; get the folder name without path
(define (folder-name file-full-path)
  (unless (file? file-full-path) (throw-error (append "file doesn't exist, file-full-path:" file-full-path)))
  (unless (directory? file-full-path) (throw-error (append "file-full-path must be a folder path, file-full-path:" file-full-path)))
  (first (regex "[^\\\\]*$" file-full-path))
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
  (println (append "XCOPY " src " " dest "\\" src))
  (exec (append "XCOPY " src " " dest "\\" src "/I /0 /X /E /H /K")))

