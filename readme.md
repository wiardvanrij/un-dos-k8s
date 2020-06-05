# Un DOS for k8s

This setup is a Proof of Concept for security reasons and education, on how to protect & test your own Kubernetes clusters. Please be responsible with the usage. 

# tl;dr

`kubectl apply -f app-deploy.yaml` Applies the base 

`kubectl proxy` Setup the proxy for easy access

`./un-dos-k8s.sh` And we gonna scale it up & down

# What / why

This is an **authorised** denial-of-service for Kubernetes "abusing" the lenght of env vars. Because it ruins my clusters pretty fast/badly, and my lack of deep Kubernetes knowledge, I cannot pin-point the actual issue and effect(s). Expect your master nodes and ETCD to either overload or just..crash.

I made this into a PoC in order to report this to Kubernetes (and Google). This issue is out-of-scope because it requires authorization. 

Personally I agree that the severity is minimal, yet it does pose a threat to "As a Service" or multi-tenant setups. Therefore I decided to just give the info to the public. 


# "How"

With our app-deploy we create a deployment which consists of a container having a huge amount of env_vars. We then just scale up&down this deployment vigorously, which causes various of things.

I have not had the time to test on what exactly happens but: 
- API Servers becomes somewhat unresponsive (or totally fcked)
- ETCD database seems to grow massively. (I.e. a 10Gb etcd database was full in ~3 minutes)

Again: because my clusters become so much unresponsive, it becomes harder to pinpoint what is happening and why, all I know is that it can ruin your clusters (either temporary or worse..)

# Why such bash file? How to tweak it

The bash file is just really basic, because I wanted to create something that was easy to read/understand for everyone (or close to it..).

It might be possible that you have to increase a few factors for greater/faster effect: 
- run multiple instances of `un-dos-k8s.sh` concurrently. 
- increase the loop size in that file

Or downscale some settings if you run into "host system" issues (such as file/network limits)
- descrease the loop size
- add an extra sleep
- increase the sleep
