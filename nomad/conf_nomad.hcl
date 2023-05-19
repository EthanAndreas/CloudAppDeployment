job "cloud" {
    datacenters = ["gare-centrale"]

    group "clouds"{
        count = 1

        network {
            port "frontend"{
                static = 3000
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
                port_map {
                    frontend = {
                        static = 3000
                    }
                }
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