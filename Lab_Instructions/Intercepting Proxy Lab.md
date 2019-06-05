
---
## Running the OWASP Juice Shop Docker

* `sudo docker run --rm -p 3000:3000 -d bkimminich/juice-shop`

---
##  Intercepting Proxy Lab

 * This is a lab to understand how we could proxy all request and responses using OWASP ZAP.
---

### Step 1: 

* Open terminal and go to ZAP folder
  * `cd Documents/zap`
* Run ZAP
  * `./zap.sh`
  
### Step 2: 

* Open Firefox browser by clicking on the icon on the desktop.

### Step 3: 

* Browse to the URL : http://localhost:3000

### Step 4:

* Select the FoxyProxy add-on in the browser and choose ZAP.

### Step 5:

* Browse around the App and notice that the request and resposes being captured inside ZAP.

---
## Setting Breakpoint for messages

---
### Step 1: 
* Click on the Set Break point button in the toolbar as shown in th image below.
  ![](/images/Break_Point_button.jpg)

### Step 2: 
* Go to the browser and click on any link and notice the request being intercepted inside ZAP.

---