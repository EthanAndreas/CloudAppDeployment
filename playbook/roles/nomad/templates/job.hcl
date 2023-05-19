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
        // Use 1 haproxy instances for all the VMs
        count = 1

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
                image = "docker.io/library/haproxy:2.7"
                ports = ["haproxy"]
            }

            // Configuration du haproxy
            template {
                data = <<EOF
                global
                    daemon
                    maxconn 1024

                defaults
                    mode http
                    balance roundrobin
                    timeout client 60s
                    timeout connect 60s
                    timeout server 60s

                frontend http
                    bind *:8080
                    default_backend web

                resolvers consul
                    nameserver consul 172.16.3.4:53
                    accepted_payload_size 8192

                backend web
                    balance roundrobin
                    mode http
                    server-template frontend _frontend._tcp.service.consul resolvers consul init-addr none
                EOF
                destination = "haproxy.cfg"
            }

        }
    }
}