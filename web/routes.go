package web

import (
	"github.com/paganotoni/jumpkit/config"
	"github.com/paganotoni/jumpkit/core/render"
	"github.com/paganotoni/jumpkit/core/session"

	"net/http"

	"github.com/paganotoni/jumpkit/web/public"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

// routes sets up all the routes for the application.
func (r *server) routes() {
	// Base middleware
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)
	r.Use(middleware.RequestID)

	// Custom General Middleware
	r.Use(session.InCtx(store, config.SessionName))
	r.Use(render.InCtx(renderer))
	r.Use(session.AddHelpers)

	r.Route("/", func(rx chi.Router) {
		rx.Get("/", func(w http.ResponseWriter, r *http.Request) {
			rw := render.FromCtx(r.Context())

			err := rw.Render("home/index.html")
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
			}
		})
	})

	// Public files that include anything thats on the
	// public folder. This is useful for files and assets.
	r.Handle("/public/*", http.StripPrefix("/public/", http.FileServer(http.FS(public.Folder))))
}
