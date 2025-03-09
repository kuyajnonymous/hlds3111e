Half Life Dedicated Server for HL1.1.1.1/46 (Support CS 1.5)

<html lang="en">
<body>

<div class="container">

<h1>Half-Life Dedicated Server (HLDS 3111e) for HL1.1.1.1/46</h1>
<p><strong>Support CS 1.5</strong></p>

<h2>HLDS 3111e - Build and Run with Docker</h2>
<p>This guide provides instructions to clone, build, and run HLDS 3111e using Docker or Docker Compose.</p>

<h2>1. Clone the HLDS 3111e Repository</h2>
<p>Run the following commands to clone the HLDS 3111e source code:</p>
<pre><code>git clone https://github.com/kuyajnonymous/hlds3111e.git
cd hlds3111e
</code></pre>

<h2>2. Build the HLDS 3111e Docker Image</h2>
<p>Build the Docker image from the repository:</p>
<pre><code>docker build -t hlds3111e .
</code></pre>

<h2>3. Run HLDS 3111e Using Docker</h2>
<p>Start the HLDS server as a Docker container:</p>
<pre><code>docker run -d --name hlds_server \
  -p 27015:27015/tcp -p 27015:27015/udp \
  hlds3111e \
  ./hlds_run +ip 0.0.0.0 +port 27015 -game cstrike +map de_dust +maxplayers 16 -noauth -insecure +sv_lan 1
</code></pre>

<h2>4. Run HLDS 3111e Using Docker Compose (Alternative Method)</h2>
<p>Create a file named <code>docker-compose.yml</code> in the <code>hlds3111e</code> directory and add the following content:</p>

<pre><code>version: '3.8'

services:
  hlds_server:
    image: hlds3111e
    container_name: hlds3111e
    restart: unless-stopped
    user: "0:0"  # Running as root (consider using a non-root user for security)
    tty: true
    stdin_open: true
#    volumes:
#      - /opt/cstrike:/server/hlds_l/cstrike # Replace with your game mode path
    ports:
      - "27015:27015/tcp"
      - "27015:27015/udp"
    command: >
      ./hlds_run +ip 0.0.0.0 +port 27015 -game cstrike +map de_dust +maxplayers 16 -noauth -insecure +sv_lan 1
    security_opt:
      - no-new-privileges:1
</code></pre>

<p>Start the HLDS server using Docker Compose:</p>
<pre><code>docker-compose up -d
</code></pre>

<h2>5. Verify the HLDS Server</h2>
<p>Check if the HLDS server is running:</p>
<pre><code>docker ps
</code></pre>

<p>To manually start HLDS inside the container:</p>
<pre><code>docker exec -it hlds3111e ./hlds_run +ip 0.0.0.0 +port 27015 -game cstrike +map de_dust +maxplayers 16 -noauth -insecure +sv_lan 1
</code></pre>

<h2>6. Notes</h2>
<p>To stop the container:</p>
<pre><code>docker stop hlds3111e
</code></pre>

<p>To restart the container:</p>
<pre><code>docker start hlds3111e
</code></pre>

<p>To remove the container:</p>
<pre><code>docker rm -f hlds3111e
</code></pre>

<div class="note">
    <strong>Now your HLDS 3111e server is running inside Docker! 🎮 🚀</strong>
</div>

</div>

</body>
</html>
