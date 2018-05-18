# envoy-dev/Two_services

-Envoy and an app (for this use case I use Flask) are running side by side inside the same container.
-Envoy proxies the app(Flask) and keeps track of vital information.

Flask app runs on port 5000
Envoy listens on port  8080
Envoys admin page is on port 8081

	1. Build the image (docker build -t two-services:v1 .)
	2. Run the docker with the image created on step 1 exposing the ports that envoy listens to (8080, 8081)(docker run -d --name thanos1 -p 5000:5000 -p 8080:8080 -p 8081:8081 two-services:v1)
	3. Test if everything works. (Curl -v localhost:8080/8081)
