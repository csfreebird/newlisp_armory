#!/usr/bin/newlisp

(define (print-seperator-line)
  (println "-------------------------------------")
  (println)
  )

(println "-------------------------------------")
(println "test none environment variable ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)


(env "NEWLISP_ARMORY_HOME" "/opt/def/abc/hij")
(println "test home folder does not exist ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)


(env "NEWLISP_ARMORY_HOME" (real-path "./file_test.lsp"))
(println "test home folder is file instead of folder ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)


;; the following test cases are under valid environment variable
(env "NEWLISP_ARMORY_HOME" (real-path "../"))
(println (append "Correct NEWLISP_ARMORY_HOME: " (env "NEWLISP_ARMORY_HOME")))
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test failed"))
(println "load file.lsp succeeded")
(print-seperator-line)

(println "test file-name function now ...")
(println "apply file-name to folder")
(unless (catch (file:file-name (real-path)) 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)

(println "apply file-name to file")
(unless (catch (set 'fname (file:file-name (real-path "./file_test.lsp"))) 'result)
	(println (append "catch error: " result))
	(println "test failed"))
(println (append "file-name test succeeded, file name is: " fname))
(print-seperator-line)

(println "test remove-last-seperator ...")
(unless (catch (set 'fpath (file:remove-last-seperator (append (real-path) "/"))) 'result)
	(println (append "catch error: " result))
	(println "test failed"))
(println (append "remove-last-seperator test succeeded, path is: " fpath))
(print-seperator-line)

(println "test folder-name ...")
(unless (catch (set 'folder-name (file:folder-name (append (real-path) "/"))) 'result)
	(println (append "catch error: " result))
	(println "test failed"))
(println (append "folder-name test succeeded, folder name is: " folder-name))
(print-seperator-line)

(println "test remove-folder ...")
(let (test-dir (append (real-path) file:file-seperator "tt"))
  (make-dir test-dir)
  (if (directory? test-dir)
      (begin
	(file:remove-folder test-dir)
	(if (file? test-dir)
	    (println "remove-folder failed")
	    (println "remove-folder succeeded")))
      (begin
	(println "remove-folder failed"))))
(print-seperator-line)

(println "test copy-folder ...")
(unless (catch (file:copy-folder (append (real-path) file:file-seperator "a") (append (real-path) file:file-seperator "a")) 'result)
	(println (append "catch error: " result))
	(println "test non-existing src folder succeeded"))
(print-seperator-line)

(let ((test-dir1 (append (real-path) file:file-seperator "a")) (test-dir2 (append (real-path) file:file-seperator "b")))
  (make-dir test-dir1)
  (if (directory? test-dir1)
      (unless (catch (file:copy-folder test-dir1 test-dir2) 'result)
	      (println (append "catch error: " result))
	      (println "test non-existing dst folder succeeded"))))
(print-seperator-line)

(let ((test-dir1 (append (real-path) file:file-seperator "a")) (test-dir2 (append (real-path) file:file-seperator "b")))
  (make-dir test-dir1)
  (make-dir test-dir2)
  (if (directory? test-dir1)
      (begin
	(unless (catch (file:copy-folder test-dir1 test-dir2) 'result)
		(println (append "catch error: " result))
		(println "test copy-folder failed"))
	(file:remove-folder test-dir1)
	(file:remove-folder test-dir2))))

(println "test copy-folder succeeded")
(print-seperator-line)

(exit)
