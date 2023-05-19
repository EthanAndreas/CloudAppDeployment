// Create a new job with the name "cloud" corresponding to the datacenter "gare-centrale" for the full project
job "cloud" {
    datacenters = ["gare-centrale"]

    // Create a new group for the frontend
    group "frontends"{
        count = 1

        network {
            port "frontend"{
                static = 3000
                to = 3000
            }

        }
        task "frontend" {
            driver = "docker"
            config {
                image = "ghcr.io/loskeeper/frontend:1.0.0" // Use the image published on the GitHub Container Registry
                ports = ["frontend"]
                port_map {
                    frontend = {
                        static = 3000
                    }
                }
            }

        }
    }

    // Create a new group for the backend
    group "workers"{
        count = 1

        network {
            port "worker"{
                static = 8080
                to = 8080
            }
        }
        task "worker" {
            driver = "docker"
            config {
                image = "ghcr.io/loskeeper/worker:1.0.0" // Use the image published on the GitHub Container Registry
                ports = ["worker"]
            }

        }

    }

    // Create a new group for the haproxy
    group "haproxys"{
        // Use 3 haproxy instances for all the VMs
        count = 3

        network {
            port "haproxy"{
                static = 80
                to = 80
            }
        }

        // Use the haproxy image from the Docker Hub
        task "haproxy" {
            driver = "docker"
            config {
                image = "docker.io/library/haproxy"
                ports = ["haproxy"]
            }

            // Use the haproxy configuration file
            resources {
                imports = ["../loadBalancer/haproxy.cfg"]
            }

        }
    }
}