{{ range counter .whitewalkers }}
module whitewalker{{.}} {
  source = "terraform-templates-modules-0a1/server"
  region = "{{ left (index $.whitewalkers_zones .) (sub (len (index $.whitewalkers_zones .)) 1) }}"
  availability_zone = "{{ index $.whitewalkers_zones . }}"
  ami_owner = "{{ $.AMI_OWNER }}"
  ami_name = "{{ $.AMI_NAME }}"
  instance_type = "{{ $.instance_type }}"
  role = "whitewalker"
  id = "{{ . }}"
  nightking_hostname = "{{ $.NIGHTKING_HOSTNAME }}"
  nightking_ip = "{{ $.NIGHTKING_IP }}"
  telegraf = "{{ $.INFLUX_TELEGRAF_PASSWORD }}"
  experiments = "{{ $.XP }}"
  cacert = "{{ $.CACERT }}"
}
{{end}}
