;; file.lsp

;; @module file
;; @description file module provides some file operations on both Ubuntu and Windows
;; @location file.lsp
;; @version 1.0
;; @author Dean Chen
;; @example
;; (env "NEWLISP_ARMORY_HOME" "/home/dean/github/newlisp_armory")
;; (file:init)
;; (let ((test-dir1 (append (real-path) file:file-seperator "a")) (test-dir2 (append (real-path) file:file-seperator "b")))
;;   (make-dir test-dir1)
;;   (make-dir test-dir2)
;;   (if (directory? test-dir1)
;;       (begin
;; 	(unless (catch (file:copy-folder test-dir1 test-dir2) 'result)
;; 		(println (append "catch error: " result))
;; 		(println "test copy-folder failed"))
;; 	(file:remove-folder test-dir1)
;; 	(file:remove-folder test-dir2))))
(context 'file)

;; @syntax (file:init)
;; @throw Throw error if environment variable NEWLISP_ARMORY_HOME does not exist or is invalid
;; @throw Throw error if OS is not Windows or UBuntu
;; @note init function will be called automatically when loading file.lsp module, don't call it manually
(define (init)
  (unless (env "NEWLISP_ARMORY_HOME")
	  (throw-error "NEWLISP_ARMORY_HOME does not exist"))
  (unless (file? (env "NEWLISP_ARMORY_HOME"))
	  (throw-error "NEWLISP_ARMORY_HOME points to a non-existing file"))
  (unless (directory? (env "NEWLISP_ARMORY_HOME"))
	  (throw-error "NEWLISP_ARMORY_HOME points to a file instead of directory"))
  (set 'file-folder (append (env "NEWLISP_ARMORY_HOME") "/codes/file"))
  (if
   (= ostype "Linux") (load (append file-folder "/file_ubuntu.lsp"))
   (= ostype "Win32") (load (append file-folder "/file_win.lsp"))
   (throw-error (append "file tool doesn't support this OS for now, ostype:" ostype))
   ))


;; @syntax (file:folder-name folder-path)
;; @param folder-path The full path of one folder.
;; @return Return the folder name
;; @throw Throw error if folder-path does not points to one valid directory
(define (folder-name folder-path)
  (unless (file? folder-path) (throw-error (append "folder doesn't exist, folder-path:" folder-path)))
  (unless (directory? folder-path) (throw-error (append "argument must be a folder path, folder-path:" folder-path)))
  (first (regex "[^/]*$" (remove-last-seperator folder-path))))

;; @syntax (file:file-name folder-path)
;; @param full-path The full path of one file.
;; @return Return the file name
;; @throw Throw error if file-path points to one folder or non-existing file

;; @syntax (file:remove-last-seperator path)
;; @param path The full path
;; @return Return the full path which is not ended with file-seperator, e.g /opt

;; @syntax (file:remove-folder dest)
;; @param dest The full path of folder
;; @throw Throw error if dest is invalid

;; @syntax (file:copy-folder src dest)
;; @param src The full path of src folder
;; @param dest The full path of dest folder
;; @throw Throw error either src or dest is not valid folder
;; @note it doesn't matter whether src and dest arguments are ended with file-seperator or not
;; if dest/src does exist before copying, it will be removed first

;; @syntax (file:clean-folder folder-path)
;; @param full-path The full path of one file.
;; @throw Throw error if file-path points to one folder or non-existing file
;; @note only implement Ubuntu version for now

;; @syntax (file:file-seperator)
;; @note the value is different on Windows and Ubuntu
;; Windows "\\"
;; Ubuntu "/"

(init)