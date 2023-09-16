package web

import (
	"embed"

	"github.com/paganotoni/jumpkit/app/config"
	"github.com/paganotoni/jumpkit/core/mdfs"
	"github.com/paganotoni/jumpkit/core/render"

	"github.com/gorilla/sessions"
)

var (
	//go:embed **/*.html
	tmpls     embed.FS
	templates = mdfs.New(tmpls, "web", config.Environment)

	//sessions store
	store = sessions.NewCookieStore([]byte(config.SessionSecret))

	// the rendering engine for the application, this
	// is used to render each of the HTML responses
	// for the application.
	renderer = render.NewEngine(
		templates,
		render.WithHelpers(helpers),
	)
)
