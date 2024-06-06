package main

import (
	"database/sql"
	"log"

	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	_ "github.com/lib/pq"
)

func main() {
	// Database connection string
	dbURL := "postgres://username:password@localhost:5433/second_database?sslmode=disable"

	// Connect to the database
	db, err := sql.Open("postgres", dbURL)
	if err != nil {
		log.Fatalf("Could not connect to the database: %v", err)
	}

	// Ensure the database connection is closed when the main function finishes
	defer db.Close()

	// Initialize the migrate instance
	driver, err := postgres.WithInstance(db, &postgres.Config{})
	if err != nil {
		log.Fatalf("Could not create the database driver: %v", err)
	}

	// Create the migrate instance pointing to the migration files in the ./go-migrate folder
	m, err := migrate.NewWithDatabaseInstance(
		"file://./go-migrate",
		"postgres", driver)
	if err != nil {
		log.Fatalf("Could not create the migrate instance: %v", err)
	}

	// Run the migrations
	if err := m.Up(); err != nil && err != migrate.ErrNoChange {
		log.Fatalf("Could not apply the migrations: %v", err)
	}

	log.Println("Migrations applied successfully")
}
