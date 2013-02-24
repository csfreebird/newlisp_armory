;; file_win.lsp
(context 'file)

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