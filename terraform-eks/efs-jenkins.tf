resource "aws_security_group" "eks-efs-sg" {
    name        = "terraform-eks-efs-jenkins"
    description = "Amazon EFS for EKS, SG for mount target"
    vpc_id      = "${aws_vpc.demo.id}"

    tags = {
        Name = "terraform-eks-efs-sg"
    }
}

resource "aws_security_group_rule" "eks-efs-ingress" {
    description              = "Allow to access file storage"
    from_port                = 2049
    protocol                 = "tcp"
    security_group_id        = "${aws_security_group.eks-efs-sg.id}"
    to_port                  = 2049
    type                     = "ingress"
    cidr_blocks              = [aws_vpc.demo.cidr_block]
}

resource "aws_efs_file_system" "eks-efs-fs" {
    creation_token = "eks-efs-fs"
    
    tags = {
        Name = "terraform-eks-efs"
    }
}

resource "aws_efs_mount_target" "eks-efs-mt" {
    count             = length(aws_subnet.demo.*.id)
    file_system_id    = aws_efs_file_system.eks-efs-fs.id
    subnet_id         = "${element(aws_subnet.demo.*.id, count.index)}"
    security_groups   = ["${aws_security_group.eks-efs-sg.id}"]
}