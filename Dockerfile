FROM ubuntu:24.04

# Mise à jour et installation de SSH + SUDO (indispensable pour qu'Ansible fonctionne)
RUN apt update && apt install -y openssh-server sudo && rm -rf /var/lib/apt/lists/*

# Configurer SSHd pour autoriser l'authentification par mot de passe et l'accès root
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Création de l'utilisateur admin et définition du mot de passe
RUN useradd -m -s /bin/bash admin \
    && echo "admin:insecure_password" | chpasswd

# Autoriser l'utilisateur admin à utiliser sudo SANS mot de passe
RUN echo 'admin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 22

# Lancement propre du serveur SSH en arrière-plan
CMD ["/usr/sbin/sshd", "-D"]