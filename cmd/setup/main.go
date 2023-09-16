package main

import (
	"fmt"

	"github.com/paganotoni/jumpkit/config"
	"github.com/paganotoni/jumpkit/internal/db"
	"github.com/paganotoni/jumpkit/postgres"

	"github.com/paganotoni/tailo"

	_ "github.com/lib/pq"
)

func main() {
	err := tailo.Setup()
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println("✅ Tailwind CSS setup successfully")

	err = db.Create(config.DatabaseURL)
	if err != nil {
		fmt.Println(err)

		return
	}

	fmt.Println("✅ Database created successfully")

	conn, err := postgres.Connection()
	if err != nil {
		fmt.Println(err)
		return
	}

	err = db.RunMigrations(postgres.Migrations, conn)
	if err != nil {
		fmt.Println(err)

		return
	}

	fmt.Println("✅ Migrations ran successfully")
}
