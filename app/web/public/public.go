package public

import (
	"embed"
	"path/filepath"

	"github.com/paganotoni/jumpkit/app/config"
	"github.com/paganotoni/jumpkit/core/mdfs"
)

var (
	//go:embed *.css
	files embed.FS

	// Folder is a mdfs instance that contains all the
	// files in the public folder.
	Folder = mdfs.New(
		files,
		filepath.Join("web", "public"),
		config.Environment,
	)
)
