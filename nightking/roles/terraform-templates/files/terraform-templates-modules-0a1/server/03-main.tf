provider aws {
  region = "${var.region}"
}

resource aws_instance stark {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  associate_public_ip_address = true
  root_block_device {
    volume_size = "${var.volume_size}"
  }
  tags {
    role: "${var.role}"
  }
}
