#|
(ql:quickload :cffi)
;(pushnew (merge-pathnames "lib" (uiop:getcwd)) cffi::*foreign-library-directories* :test #'equal)

(setf cffi::*foreign-library-directories* '(#P"V:/softdev/tktest/lib/"))
|#

; (ql:quickload :cl-cffi-gtk)

(defpackage :hello-world-gui
  (:use :gtk :gdk :gdk-pixbuf :gobject
   :glib :gio :pango :cairo :cl))

(in-package :hello-world-gui)

(defun hello-world ()
  (within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Hello Buttons"
                                 :default-width 250
                                 :default-height 75
                                 :border-width 12))
          (vbox (gtk-box-new :vertical 0)))
      (g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)
						  (uiop:quit)))
      
	  (let ((menus '("File" "Edit" "Search" "View" "Settings" "Help"))
	        (menu-bar (gtk-menu-bar-new)))
	    (loop for m in menus do
		  (let* ((item (gtk-menu-item-new-with-label m))
		         (menu (gtk-menu-new)))
			(setf (gtk-menu-item-submenu item) menu)
			(gtk-menu-shell-append menu-bar item)))
		(gtk-container-add vbox menu-bar))
	  
      (gtk-container-add window vbox)
      (gtk-widget-show-all window)))
	(gtk:join-gtk-main))  ; Needed to make sure the main lisp thread does not 
	                      ; exit until gtk has.