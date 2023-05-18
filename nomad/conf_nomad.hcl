job "cloud" {
    datacenters = ["gare-centrale"]

    group "clouds"{
        count = 2

        network {
            port "fontend"{
                static = 3000
                to = 8081
            }

            port "worker"{
                static = 8080
                to = 8080
            }
        }
        task "frontend" {
            driver = "docker"
            config {
                image = "ghcr.io/loskeeper/frontend:1.0.0"
                ports = ["fontend"]
                args = ["-p","3000:3000"]
            }

            resources {
                cpu    = 100
                memory = 128
            }
        }

        task "worker" {
            driver = "docker"
            config {
                image = "ghcr.io/loskeeper/worker:1.0.0"
                ports = ["worker"]
                args  = ["--port", "8080"]
            }

            resources {
                cpu    = 100
                memory = 128
            }
        }
    }
}