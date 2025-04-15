# Particle41-Devops-Challenge
# Step1: Install Node.js & Docker in local/Virtual machine
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt-get install -y nodejs

# Install Docker 
sudo apt update  
sudo apt install -y docker.io  
sudo systemctl enable docker  
sudo usermod -aG docker $USER
# Step2: Create a directory SimpleTimeService
mkdir SimpleTimeService && cd SimpleTimeService  
npm init -y (installing all the dependencies)  
npm install express (installing the Express.js library into project)  

Add app.js and Dockerfile in the SimpleTimeService directory.

# Step 3: Build the Docker Image
docker build -t simpletimeservice .   (To build the image)  
docker run -p 3000:3000 simpletimeservice  (To run Docker container)    
curl http://localhost:3000    (To Browse  in local)  
# Step 4: Push to DockerHub
docker login  (To Login to Docker)  
docker tag simpletimeservice piyushkeshri30/simpletimeservice:latest  (Tagging an existing Docker image with a new name )  
docker push piyushkeshri30/simpletimeservice:latest  (Pushing the image to DockerHub)  
# Step 5: Run from DockerHub
docker run -p 3000:3000 piyushkeshri30/simpletimeservice:latest   
#  Example Output
{
  "timestamp": "2025-04-13T13:15:00.123Z",  
  "ip": "::ffff:172.17.0.1"
}





