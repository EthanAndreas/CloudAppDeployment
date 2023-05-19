job "cloud" {
    datacenters = ["gare-centrale"]

    group "clouds"{
        count = 1

        network {
            port "frontend"{
                static = 8081
                to = 3000
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
                ports = ["frontend"]
            }

        }

        task "worker" {
            driver = "docker"
            config {
                image = "ghcr.io/loskeeper/worker:1.0.0"
                ports = ["worker"]
            }

        }
    }
}