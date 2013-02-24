;; file_ubuntu.lsp
(context 'file)

;; copy the src folder to dest/src recursively
;; both src and dest must be existing folders, otherwise an exception will be thrown out
;; it doesn't matter whether src and dest arguments are ended with / or not
;; note, if there is a folder which has the same name as src, the copy still work
(define (copy-folder src dest)
  (unless (file? src) (throw-error (append "src folder doesn't exist, src:" src)))
  (unless (file? dest) (throw-error (append "dest folder doesn't exist, dest:" dest)))
  (exec (append "cp -r " src " " dest)))