Half Life Dedicated Server for HL1.1.1.1/46 (Support CS 1.5)


<html lang="en">
<body>

<div class="container">

<h1>Half-Life Dedicated Server (HLDS 3111e)</h1>
<p><strong>HLDS 3111e for Counter-Strike 1.6</strong></p>

<h2>📌 1. Clone the HLDS 3111e Repository</h2>
<p>Run the following commands to clone the HLDS 3111e source code:</p>
<pre><code>git clone https://github.com/kuyajnonymous/hlds3111e.git
cd hlds3111e
</code></pre>

<h2>🔧 2. Build the HLDS 3111e Docker Image</h2>
<p>Build the Docker image from the repository:</p>
<pre><code>docker build -t hlds3111e .
</code></pre>

<h2>🚀 3. Run HLDS 3111e Using Docker</h2>
<p>Start the HLDS server as a Docker container:</p>
<pre><code>docker run -d --name hlds_server \
  -p 27015:27015/tcp -p 27015:27015/udp \
  hlds3111e \
  ./hlds_run +ip 0.0.0.0 +port 27015 -game cstrike +map de_dust2 +maxplayers 16 -noauth -insecure +sv_lan 1
</code></pre>

<h2>📌 4. Run HLDS 3111e Using Docker Compose (Alternative Method)</h2>
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
      ./hlds_run +ip 0.0.0.0 +port 27015 -game cstrike +map de_dust2 +maxplayers 16 -noauth -insecure +sv_lan 1
    security_opt:
      - no-new-privileges:1
</code></pre>

<p>Start the HLDS server using Docker Compose:</p>
<pre><code>docker-compose up -d
</code></pre>

<h2>🔄 5. Upload the HLDS 3111e Image to Docker Hub</h2>
<p>Follow these steps to push your Docker image to Docker Hub.</p>

<h3>✅ Step 1: Log in to Docker Hub</h3>
<pre><code>docker login
</code></pre>

<h3>✅ Step 2: Tag Your Image</h3>
<p>Replace <code>your-dockerhub-username</code> with your actual Docker Hub username:</p>
<pre><code>docker tag hlds3111e your-dockerhub-username/hlds3111e:latest
</code></pre>

<h3>✅ Step 3: Push the Image to Docker Hub</h3>
<pre><code>docker push your-dockerhub-username/hlds3111e:latest
</code></pre>

<h3>✅ Step 4: Verify the Upload</h3>
<p>Go to <a href="https://hub.docker.com/" target="_blank">hub.docker.com</a> and check your repository.</p>

<h2>📌 6. Pull and Run HLDS 3111e from Docker Hub (Optional)</h2>
<p>If you want to pull and run the image from Docker Hub on another machine:</p>

<pre><code>docker pull your-dockerhub-username/hlds3111e:latest
docker run -d --name hlds_server your-dockerhub-username/hlds3111e
</code></pre>

<h2>📌 7. Manage Your HLDS Container</h2>

<p>Stop the container:</p>
<pre><code>docker stop hlds3111e
</code></pre>

<p>Restart the container:</p>
<pre><code>docker start hlds3111e
</code></pre>

<p>Remove the container:</p>
<pre><code>docker rm -f hlds3111e
</code></pre>

<div class="note">
    <strong>Now your HLDS 3111e server is running inside Docker and available on Docker Hub! 🎮 🚀</strong>
</div>

</div>

</body>
</html>

