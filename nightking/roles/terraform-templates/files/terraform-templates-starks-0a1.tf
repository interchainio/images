{{ range counter .starks }}
module stark{{.}} {
  source = "terraform-templates-modules-0a1/server"
  region = "{{ left (index $.starks_zones .) (sub (len (index $.starks_zones .)) 1) }}"
  availability_zone = "{{ index $.starks_zones . }}"
  ami = "{{ $.ami }}"
  instance_type = "{{ $.instance_type }}"
  role = "stark"
}
{{end}}
