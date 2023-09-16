package render

import (
	"fmt"
	"io/fs"
	"io/ioutil"
	"net/http"
	"strings"

	"github.com/gobuffalo/plush"
)

var defaultLayout = "layouts/application.html"

func (e *Engine) HTML(w http.ResponseWriter) *Page {
	p := &Page{
		fs:     e.templates,
		writer: w,
	}

	ctx := plush.NewContext()
	for k, v := range e.values {
		ctx.Set(k, v)
	}

	for k, v := range e.helpers {
		ctx.Set(k, v)
	}

	ctx.Set("partialFeeder", func(name string) (string, error) {
		return p.open(name)
	})

	p.context = ctx

	return p
}

type Page struct {
	context *plush.Context
	writer  http.ResponseWriter
	fs      fs.FS
}

func (p *Page) Set(key string, value any) {
	p.context.Set(key, value)
}

func (p *Page) Value(key string) any {
	return p.context.Value(key)
}

func (p *Page) Render(page string) error {
	// find the template from the fs
	html, err := p.open(page)
	if err != nil {
		return fmt.Errorf("could not read file: %w", err)
	}

	html, err = plush.Render(html, p.context)
	if err != nil {
		return err
	}

	layout, err := p.open(defaultLayout)
	if err != nil {
		return fmt.Errorf("could not read file: %w", err)
	}

	layout = strings.Replace(layout, "<%= yield %>", html, 1)
	html, err = plush.Render(layout, p.context)
	if err != nil {
		return err
	}

	_, err = p.writer.Write([]byte(html))
	if err != nil {
		return fmt.Errorf("could not write to response: %w", err)
	}

	return nil
}

func (p *Page) RenderWithLayout(page, layout string) error {
	html, err := p.open(page)
	if err != nil {
		return fmt.Errorf("could not read file: %w", err)
	}

	html, err = plush.Render(html, p.context)
	if err != nil {
		return err
	}

	layout, err = p.open(layout)
	if err != nil {
		return fmt.Errorf("could not read file: %w", err)
	}

	layout = strings.Replace(layout, "<%= yield %>", html, 1)
	html, err = plush.Render(layout, p.context)
	if err != nil {
		return err
	}

	_, err = p.writer.Write([]byte(html))
	if err != nil {
		return fmt.Errorf("could not write to response: %w", err)
	}

	return nil
}

func (p *Page) RenderClean(name string) error {
	// find the template from the fs
	html, err := p.open(name)
	if err != nil {
		return fmt.Errorf("could not read file: %w", err)
	}

	html, err = plush.Render(html, p.context)
	if err != nil {
		return err
	}

	_, err = p.writer.Write([]byte(html))
	if err != nil {
		return fmt.Errorf("could not write to response: %w", err)
	}

	return nil
}

func (p *Page) open(name string) (string, error) {
	px, err := p.fs.Open(name)
	if err != nil {
		return "", fmt.Errorf("could not read file: %w", err)
	}

	html, err := ioutil.ReadAll(px)
	if err != nil {
		return "", fmt.Errorf("could not read file: %w", err)
	}

	return string(html), err
}
