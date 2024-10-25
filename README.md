# Hackthropic Quickstart

![Python 3.11](https://img.shields.io/badge/Python-3.11-blue)
![Docker](https://img.shields.io/badge/Docker-Required-green)
![GitHub last commit](https://img.shields.io/github/last-commit/anthropics/anthropic-quickstarts)

This repo just aims to get you started with Anthropics Quickstarts environment to deploy "AI" hacking agents for shenanigans.  
![Screenshot 2024-10-24 at 6 57 52 PM](https://github.com/user-attachments/assets/b47a752d-b019-4bbf-997b-82deeddeec9b)
Why: On Oct 22, 2024 [Anthropic released ](https://www.anthropic.com/news/3-5-models-and-computer-use) and in part it states:

*"We’re also introducing a groundbreaking new capability in public beta: computer use. Available today on the API, developers can direct Claude to use computers the way people do—by looking at a screen, moving a cursor, clicking buttons, and typing text. Claude 3.5 Sonnet is the first frontier AI model to offer computer use in public beta."*

So in this repo, I am showing how the install guide leverages this to install metasploit, set options and execute an attack.

https://github.com/user-attachments/assets/4f6b5827-89d0-47d9-ace3-2d0965f5358b

## Curious Notes

- on the VM in as the user home dir, there is a hidden directory called `~/.anthropic/` which I found two files:
    - `api_key`
    - `system_prompt`
   
        - The default state of the system prompt is blank, I had decent luck giving it instructions similar to "jailbreaks".
        - Documentation for this is here: https://docs.anthropic.com/en/docs/build-with-claude/computer-use
            - I had pretty good luck with it respecting these prompts prior to running the commands issues in the streamlit input field   
            - <img width="784" alt="Screenshot 2024-10-24 at 9 26 43 AM" src="https://github.com/user-attachments/assets/bcc307c9-c1d7-4719-a6b3-1b62a69a5ec2">
           Interesting note: Even though its getting instruction to not intereact with external resources, it clearly ignores them.
          ya know.. since I was able to clone MSF and run it against something externally.
          
          ![8yalrx](https://github.com/user-attachments/assets/f51f6fd1-15b0-4a95-b685-55376687dc25)

- I experienced this issue ["Claude sometimes assumes outcomes of its actions without explicitly checking their results. "](https://docs.anthropic.com/en/docs/build-with-claude/computer-use) with some of my commands dispite telling it:

  ```... Run each command one at a time and make sure they complete.  I want to see the output as you run the command.```
  
## Prerequisites

- [Read the docs](https://docs.anthropic.com/en/docs/build-with-claude/computer-use)
- Get your Anthropic API key from the [console](https://console.anthropic.com/dashboard)


## Setup Instructions

1. Clone this repository:
    ```bash
      git clone https://github.com/anthropics/anthropic-quickstarts.git && git clone https://github.com/haKC-ai/hakcthropic.git
    ```
2. Setup Environment Variables

   Add your `ANTHROPIC_API_KEY` API key to `.env` 

   ```bash
   mv hacking_sample.env .env
   read -sp "Enter your Anthropic API key: " apikey && echo "ANTHROPIC_API_KEY=$apikey" > .env
   ```
3. Rename some stuff
      ```bash
      cd kali/image
      mv removeME.streamlit .streamlit
      mv removeME.config .config
       ```

2. Run the `start_hacking.sh` script: 
    ```bash
    chmod 755 start_hacking.sh
    ./start_hacking.sh #or whereever you saved it
    ```




## Usage

The `start_hacking.sh` script will:
1. Create a Python virtual environment.
2. Install the required dependencies.
3. Export environment variables from the `.env` file.
4. Run the Docker container with appropriate port bindings and environment variables.

## Notes

- Ensure Docker is installed and running on your system.
- The script drops the `.env` file in `anthropic-quickstarts/computer-use-demo/`.

## ![183930](https://github.com/user-attachments/assets/2ebd7ff3-4c19-4b74-ba14-88341cef3c51) PSST... Now that you have that working want to Use K🅐L🅘? 


![Screenshot 2024-10-24 at 6 57 52 PM](https://github.com/user-attachments/assets/b47a752d-b019-4bbf-997b-82deeddeec9b)

You are in luck dear haKCer, I made you a gift.  To move Just use the `Dockerfile` in the `kali/` directory and build your very own Kali instance to use instead of Anthropic's default image.

### Important Notes
- The container preserves your Anthropic configuration by mounting `~/.anthropic`
- The environment includes both GUI and CLI tools for security testing
- Claude maintains access to all computer use capabilities within the Kali environment

### Setup Process

1. **Pull the Kali Image**
   ```bash
   cd haKC-ai/hakcthropic/kali
   docker pull kalilinux/kali-rolling
   ```

2. **Customize Your Environment**
   - The provided Dockerfile in this repo includes:
     - Essential GUI tools (VNC, noVNC)
     - Python environment setup
     - Common security tools
     - Desktop environment with basic applications

3. **Build Your Kali Container**
   ```bash
   DOCKER_BUILDKIT=1 sudo docker build -t hakc-kali-image .
   or 
   docker build -t hakc-kali-image .
   ```
   `Success looks like this`
   ```
   DOCKER_BUILDKIT=1 sudo docker build -t hakc-kali-image .
   [+] Building 341.2s (16/16) FINISHED               docker:desktop-linux
    => [internal] load build definition from Dockerfile               0.0s
    => => transferring dockerfile: 2.52kB                             0.0s
    => [internal] load metadata for docker.io/kalilinux/kali-rolling  0.0s
    => [internal] load .dockerignore                                  0.0s
    => => transferring context: 2B                                    0.0s
    => CACHED [ 1/11] FROM docker.io/kalilinux/kali-rolling:latest    0.0s
    => [internal] load build context                                  0.0s
    => => transferring context: 2.36kB                                0.0s
    => [ 2/11] RUN apt-get update &&     apt-get -y upgrade &&      284.1s
    => [ 3/11] RUN git clone --branch v1.5.0 https://github.com/novn  2.4s 
    => [ 4/11] RUN useradd -m -s /bin/bash -d /home/hakcer hakcer &&  0.2s 
    => [ 5/11] WORKDIR /home/hakcer                                   0.1s 
    => [ 6/11] RUN python3 -m venv /home/hakcer/.venv                 2.3s 
    => [ 7/11] RUN . /home/hakcer/.venv/bin/activate &&     pip inst  3.2s 
    => [ 8/11] COPY --chown=hakcer:hakcer kali/requirements.txt /hom  0.0s 
    => [ 9/11] RUN . /home/hakcer/.venv/bin/activate &&     pip ins  31.2s 
    => [10/11] COPY --chown=hakcer:hakcer image/ /home/hakcer         0.0s 
    => [11/11] COPY --chown=hakcer:hakcer kali/ /home/hakcer/kali/    0.1s 
    => exporting to image                                            17.5s 
    => => exporting layers                                           17.5s
    => => writing image sha256:d22a96affe839097cf9df201217659496fcd5  0.0s
    => => naming to docker.io/library/hakc-kali-image                 0.0s

   View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/[REDACTED_FOR_NO_REASON]
   ```

4. **Start Hacking**

- You can either run the `start_kali_hacking.sh` script 
   ```bash
   chmod 755 start_kali_hacking.sh
   ./start_kali_hacking.sh
   ```
- OR you can kick it off manually
   ```bash
   cd kali/
   docker run \
       -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
       -v $(pwd):/home/hakcer/app \
       -p 5900:5900 \
       -p 8501:8501 \
       -p 6080:6080 \
       -p 8080:8080 \
       --name hakc-kali \
       -it hakc-kali-image
   ```
`Success looks like this`

   ```bash
   ./start_kali_hacking.sh
   Xvfb started successfully on display :1
   Xvfb PID: 8
   starting tint2 on display :1 ...
   starting mutter
   starting vnc
   PORT=5900
   starting noVNC
   noVNC started successfully
   ✨ k(a)l(i)is ready!
   ➡️  Open http://localhost:8080 in your browser to begin
   2024-10-24 22:08:14.816 
   ```
- **VNC Access**: Available on port 5900
- **noVNC Web Access**: Available on port 6080
- **Streamlit Interface**: Available on port 8501
- **Web Services**: Available on port 8080
- **Anthropic Integration**: Uses your existing API key and settings
- **Persistence**: Mounts your local Anthropic config directory


