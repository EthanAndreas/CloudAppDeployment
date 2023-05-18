variable "bastion" {
  type    = string
  default = "185.155.93.67"
}

variable "hosts" {
  type = list(object({
    name        = string
    internal_ip = string
    vxlan_ip    = string
  }))

  default = [
    {
      name        = "tunnel"
      internal_ip = "192.168.70.100"
      vxlan_ip    = "172.16.1.0"
    },
    {
      name        = "baggersee"
      internal_ip = "192.168.70.101"
      vxlan_ip    = "172.16.1.1"
    },
    {
      name        = "boecklin"
      internal_ip = "192.168.70.102"
      vxlan_ip    = "172.16.1.2"
    },
    {
      name        = "bohrie"
      internal_ip = "192.168.70.103"
      vxlan_ip    = "172.16.1.3"
    },
    {
      name        = "broglie"
      internal_ip = "192.168.70.104"
      vxlan_ip    = "172.16.1.4"
    },
    {
      name        = "cervantes"
      internal_ip = "192.168.70.105"
      vxlan_ip    = "172.16.1.5"
    },
    {
      name        = "citadelle"
      internal_ip = "192.168.70.106"
      vxlan_ip    = "172.16.1.6"
    },
    {
      name        = "colonne"
      internal_ip = "192.168.70.107"
      vxlan_ip    = "172.16.1.7"
    },
    {
      name        = "comtes"
      internal_ip = "192.168.70.108"
      vxlan_ip    = "172.16.1.8"
    },
    {
      name        = "dante"
      internal_ip = "192.168.70.109"
      vxlan_ip    = "172.16.1.9"
    },
    {
      name        = "elmerforst"
      internal_ip = "192.168.70.110"
      vxlan_ip    = "172.16.1.10"
    },
    {
      name        = "elsau"
      internal_ip = "192.168.70.111"
      vxlan_ip    = "172.16.1.11"
    },
    {
      name        = "esplanade"
      internal_ip = "192.168.70.112"
      vxlan_ip    = "172.16.1.12"
    },
    {
      name        = "gallia"
      internal_ip = "192.168.70.113"
      vxlan_ip    = "172.16.1.13"
    },
    {
      name        = "graviere"
      internal_ip = "192.168.70.114"
      vxlan_ip    = "172.16.1.14"
    },
    {
      name        = "hautepierre"
      internal_ip = "192.168.70.115"
      vxlan_ip    = "172.16.1.15"
    },
    {
      name        = "hohwart"
      internal_ip = "192.168.70.116"
      vxlan_ip    = "172.16.1.16"
    },
    {
      name        = "kibitzenau"
      internal_ip = "192.168.70.117"
      vxlan_ip    = "172.16.1.17"
    },
    {
      name        = "krimmeri"
      internal_ip = "192.168.70.118"
      vxlan_ip    = "172.16.1.18"
    },
    {
      name        = "laiterie"
      internal_ip = "192.168.70.119"
      vxlan_ip    = "172.16.1.19"
    },
    {
      name        = "landsberg"
      internal_ip = "192.168.70.120"
      vxlan_ip    = "172.16.1.20"
    },
    {
      name        = "langstross"
      internal_ip = "192.168.70.121"
      vxlan_ip    = "172.16.1.21"
    },
    {
      name        = "neuhof"
      internal_ip = "192.168.70.122"
      vxlan_ip    = "172.16.1.22"
    },
    {
      name        = "observatoire"
      internal_ip = "192.168.70.123"
      vxlan_ip    = "172.16.1.23"
    },
    {
      name        = "poteries"
      internal_ip = "192.168.70.124"
      vxlan_ip    = "172.16.1.24"
    },
    {
      name        = "republique"
      internal_ip = "192.168.70.125"
      vxlan_ip    = "172.16.1.25"
    },
    {
      name        = "robertsau"
      internal_ip = "192.168.70.126"
      vxlan_ip    = "172.16.1.26"
    },
    {
      name        = "rotonde"
      internal_ip = "192.168.70.127"
      vxlan_ip    = "172.16.1.27"
    },
    {
      name        = "saint-christophe"
      internal_ip = "192.168.70.128"
      vxlan_ip    = "172.16.1.28"
    },
    {
      name        = "saint-florent"
      internal_ip = "192.168.70.129"
      vxlan_ip    = "172.16.1.29"
    },
    {
      name        = "schluthfeld"
      internal_ip = "192.168.70.130"
      vxlan_ip    = "172.16.1.30"
    },
    {
      name        = "universite"
      internal_ip = "192.168.70.131"
      vxlan_ip    = "172.16.1.31"
    },
    {
      name        = "wacken"
      internal_ip = "192.168.70.132"
      vxlan_ip    = "172.16.1.32"
    },
    {
      name        = "winston-churchill"
      internal_ip = "192.168.70.133"
      vxlan_ip    = "172.16.1.33"
    },
  ]
}

variable "groups" {
  type = list(object({
    name        = string
    internal_ip = string
    floating_ip = string
  }))

  default = [
    {
      name        = "aristide-briand"
      internal_ip = "172.16.2.0"
      floating_ip = "172.16.3.0"
    },
    {
      name        = "emile-mathis"
      internal_ip = "172.16.2.1"
      floating_ip = "172.16.3.1"
    },
    {
      name        = "etoile-bourse"
      internal_ip = "172.16.2.2"
      floating_ip = "172.16.3.2"
    },
    {
      name        = "faubourg-national"
      internal_ip = "172.16.2.3"
      floating_ip = "172.16.3.3"
    },
    {
      name        = "gare-centrale"
      internal_ip = "172.16.2.4"
      floating_ip = "172.16.3.4"
    },
    {
      name        = "homme-de-fer"
      internal_ip = "172.16.2.5"
      floating_ip = "172.16.3.5"
    },
    {
      name        = "jean-jaures"
      internal_ip = "172.16.2.6"
      floating_ip = "172.16.3.6"
    },
    {
      name        = "les-halles"
      internal_ip = "172.16.2.7"
      floating_ip = "172.16.3.7"
    },
    {
      name        = "montagne-verte"
      internal_ip = "172.16.2.8"
      floating_ip = "172.16.3.8"
    },
    {
      name        = "pont-phario"
      internal_ip = "172.16.2.9"
      floating_ip = "172.16.3.9"
    },
    {
      name        = "porte-blanche"
      internal_ip = "172.16.2.10"
      floating_ip = "172.16.3.10"
    },
  ]
}
