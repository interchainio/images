{{ range counter .whitewalkers }}
module whitewalker{{.}} {
  source = "terraform-templates-modules-0a1/server"
  region = "{{ left (index $.whitewalkers_zones .) (sub (len (index $.whitewalkers_zones .)) 1) }}"
  availability_zone = "{{ index $.whitewalkers_zones . }}"
  ami = "{{ $.ami }}"
  instance_type = "{{ $.instance_type }}"
  role = "whitewalker"
  volume_size = "8"
}
{{end}}
