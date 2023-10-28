$oldpath = $env:PATH
try {
	$env:PATH = ".\lib;"+$env:PATH
	sbcl --load hello-world-gui.lisp --eval '(hello-world-gui::hello-world)'
} finally {
	$env:PATH = $oldpath
}