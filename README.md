# ELK-Stack-Project
Project 1: ELK Stack Project repository for Cybersecurity BootCamp coursework
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](Images/network_diagram.png "Network Diagram")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the `beats-playbook.yml` file may be used to install only certain pieces of it, such as Filebeat.

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly avaliable, in addition to restricting access to the network.  The jump box machine is the only one that can be accessed via the internet from the identified IP address.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file system (using `Filebeat`) and system metrics such as machine uptime and CPU usage (using `Metricbeat`).

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.1.0.4   | Linux            |
| ELKServer| ELK Server | 10.1.0.7   | Linux            |
| DVWA-VM1 | Webserver  | 10.1.0.5 | Linux  |
| DVWA-VM2 (future)  |  Webserver        | 10.1.0.6  | Linux  |

*Note that due to CPU resource limitations, the DVWA-VM2 has not been deployed presently.  It can be deployed as a clone of DVWA-VM1*.

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- `72.136.0.0/16`

Machines within the network can only be accessed by jumpbox (10.1.0.4).

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes              | 72.136.0.0/16    |
| ELK Server   | Yes (port 5601 only)           | Internet                     |
|  DVWA-VM1    | Yes (port 80 only)     | Internet via loadbalancer |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it ensures that the provisioning scripts run identically and do exactly the same thing every time they run, eliminating variability between configurations. ...


The playbook implements the following tasks:
- _Installs Docker_
- _Installs Python-pip_
- _Install Docker python module_
- _Increases virtual memory_
- _Downloads and launches a docker ELK container with the following published ports: `5601` `9200` `5044`_.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker_ps](Images/docker_ps.png "docker_ps")

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- DVWA-VM1 @ `10.1.0.5`
- DVWA-VM2 (future) @ `10.1.0.6`

We have installed the following Beats on these machines:
- `Filebeat`
- `Metricbeat`

These Beats allow us to collect the following information from each machine:
- `Filebeat` generates and organizes log files to send to Elasticsearch on the ELK Server. The logs contain information about the file system such as which files have changed and when.

- `Metricbeat` collects metrics from systems and services to send to Elasticsearch on the ELK Server. The logs contain information such as CPU usage, memory, disk IO, and network IO statistics.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured on the Jump Box as well as have the webservers such as DVWA-VM1 configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:

#### Install ELK Stack on the Elk-Server
- Copy the `install-elk.yml` playbook file to the Ansible container folder _`/etc/ansible/files/`_

- Update the `hosts` file in _`/etc/ansible/`_ to include private IP of the ElkServer-VM `10.1.0.7` under `[elkservers]`

- Run the playbook using the command `ansible-playbook /etc/ansible/file/install-elk.yml`.  Then, using a web-browser, navigate to port 5601 on public IP of the Elk-Server (http://168.62.31.74:5601) to check that the installation worked as expected (i.e. Kibana is up and running). Kibana GUI should appear as below:

![Kibana Main Page](Images/kibana_main.png "Kibana Main Page")

#### Install filebeat on the webservers
- Copy the `beats-playbook.yml` playbook file and associated configuration files `filebeat.yml` and `metricbeat.yml` files to the Ansible container folder `_/etc/ansible/files_`

- Update the `hosts` file in _`/etc/ansible/`_ to include private IP of the available `[webservers]` (e.g `10.1.0.5` for DVWA-VM1)

- Run the playbook using the command `ansible-playbook /etc/ansible/files/beats-playbook.yml`. A successful playbook execution is shown below:

![Playbook Execution](Images/filebeat_playbook_run.png "Playbook Execution")

The beats data will now be available for viewing on the Kibana page as follows:
- `Filebeat` availalbe under **Add Log Data** --> **System Logs**
- `Metricbeat` available under **Add Metric Data** --> **Docker Metrics**

![Kibana Beats](Images/kibana_beats.png "Kibana Beats")

Check for successful data receipt from `Filebeat` and then navigate to the dashboard.

![Filebeat main page](Images/filebeat_main.png "Filebeat main page")

![Filebeat Dashboard](Images/filebeat_dashboard.png "Filebeat Dashboard")

Check for successful data receipt from `Metricbeat` and then navigate to the dashboard.

![Metricbeat main page](Images/metricbeat_main.png "Metricbeat main page")

![Metricbeat Dashboard](Images/metricbeat_dashboard.png "Metricbeat Dashboard")

#### Configuring Web Servers
The webservers are assumed to be available prior to installing and configuring Elasticseach.  If webservers are not already available, then the following steps can be utilized to deploy an instance of DVWA on the `[webservers]` e.g. DVWA-VMx (where x is VM1, VM2, etc..)

- Copy the `pentest.yml` playbook file to the Ansible container folder _`/etc/ansible/files`_

- Update the `hosts` file in _`/etc/ansible/`_ to include private IP under `[webservers]` (e.g. `10.1.0.5` for DVWA-VM1)

- Run the playbook using the command `ansible-playbook /etc/ansible/files/pentest.yml`.  Then, navigate to the public IP of the webserver loadbalancer (http://104.42.102.241) to check that the installation worked as expected (i.e. DVWA is up and running)
