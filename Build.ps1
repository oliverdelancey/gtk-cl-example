$LibDir = "gtk-win64-dlls"
$DistDir = "dist"
$ExecutableFile = "hello-world-gui.exe"

$ProjectName = "hello-world-gui"
$EntryPoint = "hello-world"
$Debuggable = $false

.\Clean.ps1
$oldpath = $env:PATH
try {
	echo "Building executable..."
	$env:PATH = "$LibDir;"+$env:PATH
	if ($Debuggable) {
		sbcl --load "$ProjectName.asdf" --eval "(ql:quickload :$ProjectName)" --eval "(sb-ext:save-lisp-and-die #p\""$ExecutableFile\"" :toplevel #'$ProjectName::$EntryPoint :executable t)"
	} else {
		sbcl --load "$ProjectName.asdf" --eval "(ql:quickload :$ProjectName)" --eval "(sb-ext:save-lisp-and-die #p\""$ExecutableFile\"" :toplevel #'$ProjectName::$EntryPoint :executable t :application-type :gui)"
	}
	echo "Creating directory..."
	New-Item -Path $DistDir -ItemType Directory
	echo "Adding executable to directory..."
	Move-Item -Path $ExecutableFile -Destination ".\dist"
	echo "Adding DLL's to directory..."
	Copy-Item -Path "$LibDir\*" -Destination $DistDir -Recurse
	echo "TODO: installer script that moves stuff to the right spots and makes a shortcut"
	echo "DONE"
} finally {
	$env:PATH = $oldpath
}