provider aws {
  region = "${var.region}"
}

resource aws_instance server {
  ami = "${data.aws_ami.server.id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.server.name}"
  security_groups = ["${aws_security_group.server.name}"]
  key_name = "${aws_key_pair.server.key_name}"
  root_block_device {
    volume_size = "${var.volume_size}"
  }
  tags {
    Name = "${var.role}${var.id}"
    id = "${var.id}"
    role = "${var.role}"
    nightking-hostname = "${var.nightking_hostname}"
    nightking-ip = "${var.nightking_ip}"
    telegraf = "${var.telegraf}"
    cacert = "${var.cacert}"
  }
}
