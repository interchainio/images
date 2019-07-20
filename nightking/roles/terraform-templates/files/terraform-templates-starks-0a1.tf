{{ range counter .starks }}
module stark{{.}} {
  source = "terraform-templates-modules-0a1/server"
  region = "{{ left (index $.starks_zones .) (sub (len (index $.starks_zones .)) 1) }}"
  availability_zone = "{{ index $.starks_zones . }}"
  ami_owner = "{{ $.AMI_OWNER }}"
  ami_name = "{{ $.AMI_NAME }}"
  instance_type = "{{ $.instance_type }}"
  role = "stark"
  id = "{{ . }}"
  nightking_hostname = "{{ $.NIGHTKING_HOSTNAME }}"
  nightking_ip = "{{ $.NIGHTKING_IP }}"
  telegraf = "{{ $.INFLUX_TELEGRAF_PASSWORD }}"
  experiments = "{{ $.XP }}"
  cacert = "{{ $.CACERT }}"
}
{{end}}
