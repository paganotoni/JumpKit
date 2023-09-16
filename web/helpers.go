package web

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"time"

	"github.com/gobuffalo/plush"

	"github.com/dustin/go-humanize"
	"github.com/gobuffalo/nulls"
)

// Helpers used by the application to render the templates.
var helpers = map[string]any{
	// "form":    form.Form,
	// "formFor": form.FormFor,

	"hasPrefix": func(str, prefix string) bool {
		return strings.HasPrefix(str, prefix)
	},

	"urlWithParam": func(path string, params map[string]any) string {
		u, err := url.Parse(path)
		if err != nil {
			return path
		}

		q := u.Query()
		for k, v := range params {
			q.Set(k, fmt.Sprintf("%v", v))
		}

		u.RawQuery = q.Encode()
		return u.String()
	},

	"urlHas": func(path, key, val string) bool {
		u, err := url.Parse(path)
		if err != nil {
			return false
		}

		q := u.Query()
		return q.Get(key) == val
	},

	"shortMonthWithDate": func(date interface{}) string {
		switch dd := date.(type) {
		case time.Time:
			return dd.Format("Jan 2, 2006")
		case nulls.Time:
			if !dd.Valid {
				return ""
			}

			return dd.Time.Format("Jan 2, 2006")
		}

		return ""
	},

	"formatNumber": func(value int64) string {
		newValue := humanize.Comma(value)

		return newValue
	},

	"currentPathWithoutFields": func(fields []interface{}, ctx plush.HelperContext) string {
		req, ok := ctx.Value("request").(*http.Request)
		if !ok {
			return ""
		}

		path := req.URL
		q := path.Query()
		for _, field := range fields {
			q.Del(field.(string))
		}

		path.RawQuery = q.Encode()
		return path.String()
	},

	"currentPathWithout": func(values map[string]interface{}, ctx plush.HelperContext) string {
		req, ok := ctx.Value("request").(*http.Request)
		if !ok {
			return ""
		}

		URL, err := url.QueryUnescape(req.URL.String())
		if err != nil {
			return ""
		}

		for key, val := range values {
			URL = strings.ReplaceAll(URL, fmt.Sprintf("%s=%s", key, val), "")
		}

		URL = strings.ReplaceAll(URL, "&&", "&")

		return URL
	},

	"ifURLMatches": func(pattern string, matches, notMatch any, ctx plush.HelperContext) any {
		req, ok := ctx.Value("request").(*http.Request)
		if !ok {
			return notMatch
		}

		re, err := regexp.Compile(pattern)
		if err != nil {
			return notMatch
		}

		if re.MatchString(req.URL.Path) {
			return matches
		}

		return notMatch
	},

	"setActiveClass": func(pattern []interface{}, active, inactive string, ctx plush.HelperContext) string {
		req, ok := ctx.Value("request").(*http.Request)
		if !ok {
			return inactive
		}

		pathName := req.URL.Path
		for _, p := range pattern {
			re, err := regexp.Compile(p.(string))
			if err != nil {
				return inactive
			}

			if re.MatchString(pathName) {
				return active
			}
		}

		return inactive
	},

	"isPicture": func(link string) bool {
		return strings.Contains(link, ".jpg") || strings.Contains(link, ".png") || strings.Contains(link, ".jpeg")
	},

	"timeOffDate": func(start, end time.Time) string {
		duration := end.Sub(start)

		if duration < time.Hour*8 {
			//time-offs of less than 8 hours
			return fmt.Sprintf("%s (%s - %s)", start.Format("Jan 2, 2006"), start.Format("03:04 PM"), end.Format("03:04 PM"))
		} else if duration > time.Hour*24 {
			//time-offs of more than one day's duration
			return fmt.Sprintf("%s - %s", start.Format("Jan 2, 2006"), end.Format("Jan 2, 2006"))
		}
		//time-offs of duration of 1 day or 8 hours and upwards
		return start.Format("Jan 2, 2006")
	},

	"base64JSON": func(data interface{}) string {
		bjson, err := json.Marshal(data)
		if err != nil {
			return ""
		}

		return base64.StdEncoding.EncodeToString(bjson)
	},
}
