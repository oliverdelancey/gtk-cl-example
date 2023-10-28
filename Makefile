run:
	sbcl --load test.lisp \
	     --eval '(gtk-tutorial::hello-world)'

build:
	sbcl --load test.lisp \
	     --eval "(sb-ext:save-lisp-and-die #p\"test\" :toplevel #'gtk-tutorial::hello-world :executable t)"