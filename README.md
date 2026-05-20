docker build -t monimage .

docker run -d --name ec2_simulation_1 -p 2221:22 monimage && \
docker run -d --name ec2_simulation_2 -p 2222:22 monimage && \
docker run -d --name ec2_simulation -p 2223:22 monimage

ansible-navigator run print_helloworld_playbook.yml -i inventory/hosts.yml --mode stdout
