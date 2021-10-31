FROM amazonlinux:2

# yum update & install essential packages
RUN yum update -y \
    && yum install -y \
    sudo \
    shadow-utils \
    procps \
    wget \
    openssh-server \
    openssh-clients \
    which \
    tar \
    unzip \
    iproute \
    e2fsprogs \
    && yum clean all

# Install setuptools
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python

# Create user (can sudo without password)
RUN useradd "ec2-user" \
    && echo "ec2-user ALL=NOPASSWD: ALL" >> /etc/sudoers \
    && echo "export LANG=en_US.UTF-8" >> /home/ec2-user/.bash_profile

# SSH configuration
COPY ./ssh/id_rsa.pub /home/ec2-user/.ssh/id_rsa.pub
RUN systemctl enable sshd.service \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && cat /home/ec2-user/.ssh/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys
RUN chown -R ec2-user. /home/ec2-user

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install

# init
CMD ["/sbin/init"]
