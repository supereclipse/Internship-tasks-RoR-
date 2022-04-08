Arseniy Kuzmenkov

instructions for hw4
1. git clone hw4
2. cd ./hw1
3. docker build . -t dz4
4. docker run -it --rm -p 8080:5678 dz4

URL to check http://127.0.0.1:8080/vmcost?cpu=10&ram=2&hdd_type=sata&hdd_capacity=1030&vol_arr[]=sata&vol_arr[]=2540&vol_arr[]=sas&vol_arr[]=1004

or http://127.0.0.1:8080/vmcost?cpu=10&ram=2&hdd_type=sata&hdd_capacity=1030