![Ncloud - Highly scalable NAS](https://github.com/project-ncloud/get_started/raw/main/logo.png)

## Requirements

- Ubuntu/Raspbian or any Linux distro
- Some Packages
- Some Storage

## Check for Dependencies

Open terminal and paste below code.

> bash <(curl -s https://raw.githubusercontent.com/project-ncloud/get_started/main/check_compatibility.sh)

If you see all the are green that means everything is available to setup **Ncloud**.
Otherwise you will have to run below command.

> bash <(curl -s https://raw.githubusercontent.com/project-ncloud/get_started/main/init_ubuntu.sh)

## Setup NCloud

Before start setup, We will suggest you to make a separate folder. Then open terminal in that directory. After that do all the operations.

#### Setup Master Server

> bash <(curl -s https://raw.githubusercontent.com/project-ncloud/get_started/main/setup_master.sh)

#### Setup Node Server

> sudo bash <(curl -s https://raw.githubusercontent.com/project-ncloud/get_started/main/setup_master.sh)

#### Setup NCloud Front-end

> bash <(curl -s https://raw.githubusercontent.com/project-ncloud/get_started/main/setup_ncloud.sh)

##### Note:

> While setup master server, it will asks for admin pasword. Make sure you remember it. It will be required while you setup node_server in other nodes as well as in current node where master server is placed.

## Run Server

You will have to run three different servers for ncloud.
To run each one of them you will have to goto that directory and paste following codes.

#### Master Server

> bash start.sh

#### Node Server

> sudo bash start.sh

#### Ncloud Server

> bash start.sh

## At last

Thank you for trying. Give us star if you like our project.
