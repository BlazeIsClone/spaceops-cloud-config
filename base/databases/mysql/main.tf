resource "google_sql_database_instance" "mysql_primary" {
  region           = var.region
  name             = "spaceops-north"
  database_version = "MYSQL_8_0"

  settings {
    tier      = "db-f1-micro"
    disk_size = "10"

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "public-network"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "spaceops_mission_ctrl_database" {
  name     = "spaceops_mission_ctrl"
  instance = google_sql_database_instance.mysql_primary.name
}

resource "google_sql_database" "spaceops_mission_ctrl_staging_database" {
  name     = "spaceops_mission_ctrl_staging"
  instance = google_sql_database_instance.mysql_primary.name
}

resource "google_sql_user" "spaceops_user" {
  name     = "spaceops"
  password = "password"
  host     = "%"
  instance = google_sql_database_instance.mysql_primary.name
}
